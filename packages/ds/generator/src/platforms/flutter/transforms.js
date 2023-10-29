const _camelCase = require('lodash/camelCase')
const { getBasePxFontSize } = require('../../utils/adapters')

module.exports = {
  'name/flutter/stack': {
    type: 'name',
    matcher: token => token.name.endsWith('Stack'),
    transformer: token => token.name.replace(/[Ss]tack$/, ''),
  },

  'size/flutter/height': {
    type: 'value',
    matcher: token => token.attributes.category === 'height',
    transformer: token => (parseFloat(token.value, 10) / 100).toFixed(2),
  },

  'font/flutter/weight': {
    type: 'value',
    matcher: token => token.attributes.type === 'font' && token.attributes.category === 'weight',
    transformer: token => `FontWeight.w${token.value}`,
  },

  'size/flutter/rem': {
    type: 'value',
    matcher: token => token.attributes.category === 'size' && token.value.match(/rem$/),
    transformer: (token, options) => {
      const baseFont = getBasePxFontSize(options)
      return (parseFloat(token.value, 10) * baseFont).toFixed(2)
    },
  },

  'size/flutter/px2double': {
    type: 'value',
    matcher: token => {
      return token.attributes.category === 'size' && token.attributes.type !== 'radius' && token.value.split(' ').length === 1
    },
    transformer: token => parseFloat(token.value, 10).toFixed(2),
  },

  'size/flutter/shadow': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type === 'shadow' && value.split(' ').length === 3,
    transformer: token => {
      const [offsetX, offsetY, blurRadius] = token.value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `Shadow(blurRadius: ${blurRadius}, offset: Offset(${offsetX}, ${offsetY}))`
    },
  },

  'size/flutter/spacing/squish': {
    type: 'value',
    matcher: ({ value, attributes: { category, type } }) =>
      category === 'size' && type === 'spacing_squish' && value.split(' ').length === 2,
    transformer: token => {
      const [vertical, horizontal] = token.value.split(' ')
        .map(value => parseFloat(value, 10).toFixed(2))
      return `EdgeInsets.symmetric(vertical: ${vertical}, horizontal: ${horizontal})`
    },
  },

  'size/flutter/radius': {
    type: 'value',
    matcher: ({ value, attributes: { type } }) =>
      type === 'radius' && value.split(' ').length === 1,
    transformer: token => {
      let value = parseFloat(token.value, 10)
      if (token.value.includes('%')) {
        value = value / 100
        // currently Flutter does not support percentage radius
        // issue: https://github.com/flutter/flutter/issues/135689
        // adding this below transformation, will delegates to the consumer
        // to provide an import with a custom implementation of `PercentageBorderRadius`
        // I don't know what is the best way to handle it, but this is the best I can think of
        console.info('Please provide an import with a custom implementation of `PercentageBorderRadius`')
        return `PercentageBorderRadius.all(Radius.circular(${value.toFixed(2)}))`
      }
      return `BorderRadius.all(Radius.circular(${value.toFixed(2)}))`
    },
  },

  'text/flutter/style': {
    type: 'value',
    matcher: ({ attributes: { category, type } }) =>
      type === 'text' && category === 'style',
    transformer: token => {
      const textStyleData = token.value
      const textStyleDataCamelCase = textStyleData.split(';')
        .reduce(
          (acc, cur) => {
            const [key, value] = cur.split(':')
            return `${acc}${_camelCase(key)}: ${value},`
          },
          '',
        )
      return `TextStyle(${textStyleDataCamelCase})`
    },
  },
}
