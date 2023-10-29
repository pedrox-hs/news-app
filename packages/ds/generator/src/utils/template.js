const fs = require('fs')
const path = require('path')
const formatHelpers = require('style-dictionary/lib/common/formatHelpers')
const _template = require('lodash/template')

module.exports = {
  formatsFromTemplatesPath: (platform, templatesPath) => {
    const templates = fs.readdirSync(templatesPath)
      .filter((file) => file.endsWith('.template'))

    return templates.reduce((acc, template) => {
      const name = `${platform}/${template.replace(/\.template$/, '')}`
      const templatePath = path.join(templatesPath, template)

      return {
        ...acc,
        [name]: {
          formatter: function (dictionary, config, file) {
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
  },
}
