const StyleDictionary = require('style-dictionary-generator')
const path = require('path')

module.exports = StyleDictionary.extend({
  source: [
    'properties/**/*.json',
  ],
  transform: {
    // override 'size/flutter/radius' transform
    // because we need to support percentage radius
    // unfortunately, Flutter does not support it yet
    // issue: https://github.com/flutter/flutter/issues/135689
    'size/flutter/radius': {
      type: 'value',
      matcher: ({ value, attributes: { type, category } }) =>
        (type === 'radius' || category === 'radius') && value.match(/^\d+(px|%)?$/),
      transformer: token => {
        let value = parseFloat(token.value, 10)
        if (token.value.includes('%')) {
          value = value / 100
          return `PercentageBorderRadius.all(Radius.circular(${value.toFixed(2)}))`
        }
        return `BorderRadius.all(Radius.circular(${value.toFixed(2)}))`
      },
    },

    // override 'size/flutter/asset' transform
    // to transform asset uri to LocalSvgAsset type
    'asset/flutter/path': {
      type: 'value',
      matcher: ({ value }) => typeof value === 'string' && value.match(/^assets:\/\/.+\.svg$/),
      transformer: ({ value }) => {
        const packageName = path.basename(__dirname)
        return `LocalSvgAsset('packages/${packageName}/${value.replace(/:\//, '')}')`
      },
    },
  },
  platforms: {
    flutter: {
      transformGroup: 'meiuca-flutter',
      buildPath: './build/style_dictionary/',
      actions: ['flutter/aggregate'],
      options: {
        showFileHeader: false,
        flutterAggregate: {
          outputPath: './lib/src',
          className: 'JDesignTokens',
        },
      },
      files: [
        {
          destination: 'color.dart',
          format: 'flutter/class.dart',
          className: 'Color',
          filter: {
            attributes: {
              category: 'color',
            },
          },
        },
        {
          destination: 'font.dart',
          format: 'flutter/class.dart',
          className: 'Font',
          filter: {
            attributes: {
              type: 'font',
            },
          },
        },
        {
          destination: 'spacing.dart',
          format: 'flutter/class.dart',
          className: 'Spacing',
          imports: [
            'package:flutter/painting.dart',
          ],
          filter: ({ attributes: { type, subitem } }) => {
            return type.startsWith('spacing') && (type !== 'spacing_squish' || subitem === 'stack')
          },
        },
        {
          destination: 'asset.dart',
          format: 'flutter/class.dart',
          className: 'Asset',
          imports: [
            'package:design_system/src/types.dart',
          ],
          filter: {
            attributes: {
              type: 'asset',
            },
          },
        },
        {
          destination: 'border.dart',
          format: 'flutter/class.dart',
          className: 'Border',
          imports: [
            'package:flutter/painting.dart',
          ],
          filter: {
            attributes: {
              type: 'border',
            },
          },
        },
        {
          destination: 'radius.dart',
          format: 'flutter/class.dart',
          className: 'Radius',
          imports: [
            'package:flutter/painting.dart',
          ],
          filter: {
            attributes: {
              type: 'radius',
            },
          },
        },
        {
          destination: 'opacity.dart',
          format: 'flutter/class.dart',
          className: 'Opacity',
          filter: {
            attributes: {
              type: 'opacity',
            },
          },
        },
        {
          destination: 'shadow.dart',
          format: 'flutter/class.dart',
          className: 'Shadow',
          filter: {
            attributes: {
              type: 'shadow',
              subitem: 'stack',
            },
          },
        },
        {
          destination: 'typography.dart',
          format: 'flutter/factory.dart',
          className: 'Typography',
          factoryName: 'TextStyle',
          imports: [
            'package:flutter/painting.dart',
          ],
          filter: {
            attributes: {
              type: 'text',
              category: 'style',
            },
          },
        },
        {
          destination: 'button.dart',
          format: 'flutter/factory.dart',
          className: 'Button',
          factoryName: 'ButtonStyleData',
          imports: [
            'package:design_system/src/types.dart',
          ],
          filter: {
            attributes: {
              type: 'button',
              category: 'style',
            },
          },
        },
        {
          destination: 'shape.dart',
          format: 'flutter/factory.dart',
          className: 'Shape',
          factoryName: 'ShapeStyleData',
          imports: [
            'package:design_system/src/types.dart',
          ],
          filter: {
            attributes: {
              type: 'shape',
            },
          },
        },
      ],
    },
  },
})
