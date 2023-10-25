const StyleDictionary = require('style-dictionary-generator')

module.exports = StyleDictionary.extend({
    source: [
        "properties/**/*.json"
    ],
    platforms: {}
});