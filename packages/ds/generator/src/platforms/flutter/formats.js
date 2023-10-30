const path = require('path')
const { formatsFromTemplatesPath } = require('@utils/template')

const platform = 'flutter'
const templatesPath = path.join(__dirname, 'templates')

module.exports = formatsFromTemplatesPath(platform, templatesPath)
