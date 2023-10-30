const fs = require('fs')
const path = require('path')
const StyleDictionary = require('style-dictionary')

const registers = [
  ['formats', 'registerFormat'],
  ['actions', 'registerAction'],
  ['transforms', 'registerTransform'],
  ['transformGroups', 'registerTransformGroup'],
]

const isScript = path => fs.existsSync(`${path}.js`)
const isDirectory = path => fs.lstatSync(path).isDirectory()

function registerFromPlatformsPath (platformsPath) {
  fs.readdirSync(platformsPath)
    .filter(platform => isDirectory(path.join(platformsPath, platform)))
    .forEach(platform => {
      registerFromDefinitionsPath(path.join(platformsPath, platform))
    })
}

function registerFromDefinitionsPath (definitionsPath) {
  for (const [key, register] of registers) {
    const registryPath = path.join(definitionsPath, key)

    if (!isScript(registryPath) && !isDirectory(registryPath)) {
      continue
    }

    const definitions = require(registryPath)

    for (const name in definitions) {
      StyleDictionary[register]({ name, ...(definitions[name]) })
    }
  }
}

module.exports = {
  registerFromPlatformsPath,
  registerFromDefinitionsPath,
}
