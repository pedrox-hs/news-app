module.exports = {
  env: {
    commonjs: true,
    es2021: true,
    node: true,
  },
  extends: [
    'standard',
    // https://github.com/ota-meshi/eslint-plugin-lodash-template
    'plugin:lodash-template/recommended',
  ],
  overrides: [
    {
      env: {
        node: true,
      },
      files: [
        '.eslintrc.{js,cjs}',
      ],
      parserOptions: {
        sourceType: 'script',
      },
    },
    {
      files: ['src/templates/**/*.template'],
      processor: 'lodash-template/base',
    },
  ],
  parserOptions: {
    ecmaVersion: 'latest',
  },
  rules: {
    semi: ['warn', 'never'],
    'comma-dangle': ['warn', 'always-multiline'],
  },
}
