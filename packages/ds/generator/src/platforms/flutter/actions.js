const fs = require('fs')
const path = require('path')

module.exports = {
  'flutter/aggregate': {
    do: (_, config) => {
      const {
        outputPath = config.buildPath,
        destination = 'style_dictionary.dart',
        className = 'StyleDictionary',
        additionalImports = [],
      } = config.options.flutterAggregate || {}

      const allImports = [
        ...additionalImports.map((line) => `import '${line}';`),
      ]
      const aggregatedClassesFilePath = path.join(outputPath, destination)
      const files = fs.readdirSync(config.buildPath, { recursive: true })

      const allTokens = files
        .filter((file) => file !== destination && file.endsWith('.dart'))
        .flatMap((file) => {
          const filePath = path.join(config.buildPath, file)
          const fileContent = fs.readFileSync(filePath, 'utf8')
          let className = ''

          const lines = fileContent
            .split('\n')
            .filter((line) => {
              switch (true) {
                case line.trim().length === 0:
                  return false
                case line.includes('static '):
                  return true
                case line.startsWith('import '):
                  if (!allImports.includes(line)) {
                    allImports.push(line)
                  }
                  return false
                case line.startsWith('class'):
                  className = line.split(' ')[1]
                  return false
                default:
                  return false
              }
            })

          if (!filePath.includes('/lib/')) {
            // rename file to avoid StyleDictionary from reading it again
            fs.renameSync(filePath, `${filePath}.old`)
          }

          return [
            `\n  // region: ${className}`,
            ...lines,
            '  // endregion',
          ]
        })

      const newLines = [
        '// GENERATED CODE - DO NOT MODIFY BY HAND\n',
        ...allImports,
        `class ${className} {`,
        `  ${className}._();`,
        ...allTokens,
        '}\n',
      ]

      fs.writeFileSync(aggregatedClassesFilePath, Object.values(newLines).join('\n'))
    },
  },
}
