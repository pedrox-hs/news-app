const fs = require('fs')
const path = require('path')
const formatHelpers = require('style-dictionary/lib/common/formatHelpers')
const _template = require('lodash/template')
const _camelCase = require('lodash/camelCase')
const _isPlainObject = require('lodash/isPlainObject')

function formatsFromTemplatesPath (platform, templatesPath) {
  const templates = fs.readdirSync(templatesPath)
    .filter((file) => file.endsWith('.template'))

  return templates.reduce((acc, template) => {
    const name = `${platform}/${template.replace(/\.template$/, '')}`
    const templatePath = path.join(templatesPath, template)

    return {
      ...acc,
      [name]: {
        formatter: (dictionary, config, file) => {
          const content = fs.readFileSync(templatePath)
          const template = _template(content)
          return template({
            require,
            context: { file, config, dictionary, formatHelpers },
          })
        },
      },
    }
  }, {})
}

function formatNewDartObject (classOrFactory, attributes) {
  const factoryArgs = Object.entries(attributes)
    .reduce((acc, [name, value]) => {
      if (_isPlainObject(value)) {
        value = formatNewDartObject(name, value)
      }
      return `${acc}${_camelCase(name)}: ${value},`
    }, '')

  return `${classOrFactory}(${factoryArgs});`
}

module.exports = {
  formatsFromTemplatesPath,
  formatNewDartObject,
}
