const fs = require('fs')
const path = require('path')
const formatHelpers = require('style-dictionary/lib/common/formatHelpers')
const _template = require('lodash/template')
const { camelCase, isPlainObject, upperFirst } = require('lodash')

function formatsFromTemplatesPath (platform, templatesPath) {
  const templates = fs.readdirSync(templatesPath)
    .filter((file) => file.endsWith('.template'))

  return templates.reduce((acc, template) => {
    const name = `${platform}/${template.replace(/\.template$/, '')}`
    const templatePath = path.join(templatesPath, template)

    return {
      ...acc,
      [name]: {
        formatter: (dictionary, options, file) => {
          const content = fs.readFileSync(templatePath)
          const template = _template(content)
          return template({
            require,
            context: { file, options, dictionary, formatHelpers },
          })
        },
      },
    }
  }, {})
}

function formatNewDartObject (classOrFactory, attributes) {
  classOrFactory = classOrFactory.split('.', 2).map((part, index) => {
    if (index === 0) {
      return upperFirst(camelCase(part))
    }
    return part
  }).join('.')

  const factoryArgs = Object.entries(attributes)
    .reduce((acc, [name, value]) => {
      if (isPlainObject(value)) {
        value = formatNewDartObject(name, value)
      }
      return `${acc}${camelCase(name)}: ${value},`
    }, '')

  return `${classOrFactory}(${factoryArgs})`
}

module.exports = {
  formatsFromTemplatesPath,
  formatNewDartObject,
}
