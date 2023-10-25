const fs = require('fs')
const path = require('path')
const _template = require('lodash/template')

const platformsPath = path.join(__dirname, 'platforms')

const createDefinitionFromDir = (dir) => {
  const definition = require(path.join(dir, 'config.js'))
  const platform = path.basename(dir)
  return {
    [platform]: {
      ...definition,
      templates: definition.templates
        .reduce((acc, template) => Object.assign(acc, templateDefinition(platform, template)), {}),
    },
  }
}

const templateDefinition = (platform, templateName) => {
  const fullName = `${platform}/${templateName.replace(/\.template$/, '')}`
  const templateFile = path.resolve(__dirname, 'platforms', platform, 'templates', templateName)
  return {
    [fullName]: function _templateBuilder ({ dictionary, options, file }) {
      const template = _template(templateFile)
      return template()
    },
  }
}

const definitions = fs.readdirSync(platformsPath)
  .map((file) => path.join(platformsPath, file))
  .filter((file) => fs.statSync(file).isDirectory())
  .map(createDefinitionFromDir)
  .reduce((acc, current) => Object.assign(acc, current), {})

module.exports = definitions
