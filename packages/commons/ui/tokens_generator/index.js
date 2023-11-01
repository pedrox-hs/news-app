require('module-alias/register')

const path = require('path')
const StyleDictionary = require('style-dictionary')
const { registerFromPlatformsPath } = require('@utils/registry')

const platformsPath = path.join(__dirname, 'src', 'platforms')

registerFromPlatformsPath(platformsPath)

module.exports = StyleDictionary
