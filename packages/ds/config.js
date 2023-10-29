const StyleDictionary = require('style-dictionary-generator')

module.exports = StyleDictionary.extend({
  source: [
    'properties/**/*.json',
  ],
  platforms: {
    flutter: {
      transformGroup: 'meiuca-flutter',
      buildPath: './build/style_dictionary/',
      actions: ['flutter/aggregate'],
      basePxFontSize: 1,
      options: {
        showFileHeader: false,
        flutterAggregate: {
          outputPath: './lib/src',
          className: 'JDesignTokens',
          additionalImports: [
            "import 'package:ds/src/types.dart';",
            "import 'package:flutter/painting.dart';",
          ],
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
          destination: 'spacing.dart',
          format: 'flutter/class.dart',
          className: 'Spacing',
          filter: {
            attributes: {
              type: 'spacing',
            },
          },
        },
        {
          destination: 'spacing_squish.dart',
          format: 'flutter/class.dart',
          className: 'SpacingSquish',
          filter: {
            attributes: {
              type: 'spacing_squish',
              subitem: 'stack',
            },
          },
        },
        {
          destination: 'border.dart',
          format: 'flutter/class.dart',
          className: 'Border',
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
      ],
    },
  },
})
