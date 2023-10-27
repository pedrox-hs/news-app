const _ = require('lodash')
const { isInteger } = require('../../utils')

module.exports = {
  templates: [
    'dimensions.dart.template',
    'theme.dart.template',
  ],
  transforms: {
    'name/flutter/field': {
      type: 'name',
      transformer: function flutterFieldName (token, options) {
        const fieldName = _.camelCase(
          [options.prefix].concat(token.path.slice(1, token.path.length)).join(' '),
        )
        return isInteger(fieldName) ? 'v' + fieldName : fieldName
      },
    },
  },
}
