const StyleDictionary = require('style-dictionary')
const definitions = require('./src')

for (const platform in definitions) {
  const templates = definitions[platform].templates
  const transforms = definitions[platform].transforms

  for (const name in templates) {
    const formatter = templates[name]
    StyleDictionary.registerFormat({ name, formatter })
  }

  for (const name in transforms) {
    const transform = transforms[name]
    StyleDictionary.registerTransform({ name, ...transform })
  }

  StyleDictionary.registerTransformGroup({
    name: `meiuca-${platform}`,
    transforms: [
      'attribute/cti',
      ...Object.getOwnPropertyNames(transforms),
    ],
  })
}

module.exports = StyleDictionary
