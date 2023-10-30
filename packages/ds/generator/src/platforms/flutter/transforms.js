const { getBasePxFontSize } = require('@utils/adapters')

module.exports = {
  'name/flutter/stack': {
    type: 'name',
    matcher: ({ name }) => name.endsWith('Stack'),
    transformer: ({ name }) => name.replace(/[Ss]tack$/, ''),
  },

  'size/flutter/height': {
    type: 'value',
    matcher: ({ attributes: { category } }) =>
      category === 'height',
    transformer: ({ value }) => (parseFloat(value, 10) / 100).toFixed(2),
  },

  'font/flutter/weight': {
    type: 'value',
    matcher: ({ attributes: { category, type } }) =>
      type === 'font' && category === 'weight',
    transformer: ({ value }) => `FontWeight.w${value}`,
  },

  'size/flutter/remToDouble': {
    type: 'value',
    matcher: ({ value, attributes: { type, category } }) =>
      category === 'size' && type === 'font' && value.match(/^\d+(rem)?$/),
    transformer: ({ value }, options) => {
      const baseFont = getBasePxFontSize(options)
      return (parseFloat(value, 10) * baseFont).toFixed(2)
    },
  },

  'size/flutter/px2double': {
    type: 'value',
    matcher: ({ value, attributes: { category } }) =>
      category === 'size' && value.match(/^\d+(px)?$/),
    transformer: ({ value }) => parseFloat(value, 10).toFixed(2),
  },

  'size/flutter/shadow': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type === 'shadow' && value.match(/^\d+(px)? \d+(px)? \d+(px)?$/),
    transformer: ({ value }) => {
      const [offsetX, offsetY, blurRadius] = value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `Shadow(blurRadius: ${blurRadius}, offset: Offset(${offsetX}, ${offsetY}))`
    },
  },

  'size/flutter/spacing/bottom': {
    type: 'value',
    matcher: ({ attributes: { category, type } }) =>
      category === 'size' && type === 'spacing',
    transformer: token => {
      const value = parseFloat(token.value, 10).toFixed(2)
      return `EdgeInsets.only(bottom: ${value})`
    },
  },

  'size/flutter/spacing/symmetric': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type.startsWith('spacing_') && value.match(/^\d+(px)? \d+(px)?$/),
    transformer: ({ value }) => {
      const [vertical, horizontal] = value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `EdgeInsets.symmetric(vertical: ${vertical}, horizontal: ${horizontal})`
    },
  },

  'size/flutter/spacing/all': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type.startsWith('spacing_') && value.match(/^\d+(px)?$/),
    transformer: token => {
      const value = parseFloat(token.value, 10).toFixed(2)
      return `EdgeInsets.all(${value})`
    },
  },

  'size/flutter/radius': {
    type: 'value',
    matcher: ({ value, attributes: { type, category } }) =>
      (type === 'radius' || category === 'radius') && value.match(/^\d+(px)?$/),
    transformer: token => {
      const value = parseFloat(token.value, 10)
      return `BorderRadius.all(Radius.circular(${value.toFixed(2)}))`
    },
  },

  'size/flutter/asset': {
    type: 'value',
    matcher: ({ attributes: { type, category } }) =>
      category === 'size' && type === 'asset',
    transformer: ({ value }) => {
      const [width, height] = value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `Size(${width}, ${height || width})`
    },
  },

  'asset/flutter/path': {
    type: 'value',
    matcher: ({ value }) => typeof value === 'string' && value.startsWith('assets://'),
    transformer: ({ value }) => `'${value}'`,
  },
}
