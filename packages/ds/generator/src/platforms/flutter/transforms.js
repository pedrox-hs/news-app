const { getBasePxFontSize } = require('../../utils/adapters')

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

  'size/flutter/rem': {
    type: 'value',
    matcher: ({ value, attributes: { category } }) =>
      category === 'size' && value.match(/rem$/),
    transformer: ({ value }, options) => {
      const baseFont = getBasePxFontSize(options)
      return (parseFloat(value, 10) * baseFont).toFixed(2)
    },
  },

  'size/flutter/px2double': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type !== 'radius' && value.split(' ').length === 1,
    transformer: ({ value }) => parseFloat(value, 10).toFixed(2),
  },

  'size/flutter/shadow': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type === 'shadow' && value.split(' ').length === 3,
    transformer: ({ value }) => {
      const [offsetX, offsetY, blurRadius] = value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `Shadow(blurRadius: ${blurRadius}, offset: Offset(${offsetX}, ${offsetY}))`
    },
  },

  'size/flutter/spacing/squish': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type === 'spacing_squish' && value.split(' ').length === 2,
    transformer: ({ value }) => {
      const [vertical, horizontal] = value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `EdgeInsets.symmetric(vertical: ${vertical}, horizontal: ${horizontal})`
    },
  },

  'size/flutter/radius': {
    type: 'value',
    matcher: ({ value, attributes: { type } }) =>
      type === 'radius' &&
      value.split(' ').length === 1 &&
      // currently Flutter does not support percentage radius
      // issue: https://github.com/flutter/flutter/issues/135689
      !value.includes('%'),
    transformer: token => {
      const value = parseFloat(token.value, 10)
      return `BorderRadius.all(Radius.circular(${value.toFixed(2)}))`
    },
  },
}
