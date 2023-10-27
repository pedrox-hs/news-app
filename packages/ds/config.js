const StyleDictionary = require('style-dictionary-generator')

module.exports = StyleDictionary.extend({
    source: [
        "properties/**/*.json"
    ],
    platforms: {
        // flutter: {
        //     transformGroup: "meiuca-flutter",
        //     buildPath: "./lib/",
        //     files: [
        //         // {
        //         //     destination: "theme.dart",
        //         //     format: "flutter/theme.dart",
        //         // },
        //         {
        //             destination: "dimensions.dart",
        //             format: "flutter/dimensions.dart",
        //             prefix: "app",
        //             filter: {
        //                 attributes: {
        //                     category: "size",
        //                     type: "border",
        //                 }
        //             },
        //         },
        //     ],
        // }
        "flutter-separate": {
            "transformGroup": "flutter-separate",
            "buildPath": "./lib/src/style_dictionary/",
            "files": [
                {
                    "destination": "color.dart",
                    "format": "flutter/class.dart",
                    "className": "JColor",
                    "type": "color",
                    "filter": {
                        "attributes": {
                            "category": "color"
                        }
                    }
                },
                {
                    "destination": "border.dart",
                    "format": "flutter/class.dart",
                    "className": "JBorder",
                    "type": "float",
                    "filter": {
                        "attributes": {
                            "type": "border"
                        }
                    }
                },
                {
                    "destination": "opacity.dart",
                    "format": "flutter/class.dart",
                    "className": "JOpacity",
                    "type": "float",
                    "filter": {
                        "attributes": {
                            "type": "opacity"
                        }
                    }
                },
                {
                    "destination": "spacing.dart",
                    "format": "flutter/class.dart",
                    "className": "JSpacing",
                    "type": "float",
                    "filter": {
                        "attributes": {
                            "type": "spacing"
                        }
                    }
                },
                {
                    "destination": "font.dart",
                    "format": "flutter/class.dart",
                    "className": "JFont",
                    "type": "float",
                    "filter": {
                        "attributes": {
                            "type": "font"
                        }
                    }
                }
            ]
        }
    }
});