const dotenv = require('dotenv')
dotenv.config({ path: `${__dirname}/../.env` })
const axios = require('axios')
const unflatten = require('flat').unflatten
const fs = require('fs')
const jsyaml = require('js-yaml')

;(async function getTranslations() {
  console.log('==== Getting localizations')
  const translations = (
    await axios.get('https://localizer.todomaster.com/localizations?tag=telegram')
  ).data.filter((l) => {
    return l.tags.indexOf('telegram') > -1
  })
  console.log('==== Got localizations:')
  console.log(JSON.stringify(translations, undefined, 2))
  // Get flattened map
  const flattenedMap = {} // { key: {en: '', ru: ''}}
  translations.forEach((t) => {
    const key = t.key
    const variants = t.variants.filter((v) => !!v.selected)
    flattenedMap[key] = variants.reduce((p, c) => {
      p[c.language] = c.text
      return p
    }, {})
  })
  console.log('==== Decoded response:')
  console.log(flattenedMap)
  // Reverse the map
  const reversedMap = {}
  Object.keys(flattenedMap).forEach((k) => {
    const internals = flattenedMap[k]
    for (const language in internals) {
      const text = internals[language]
      if (!reversedMap[language]) {
        reversedMap[language] = {}
      }
      reversedMap[language][k] = text
    }
  })
  const unflattened = unflatten(reversedMap)
  console.log('==== Reversed and unflattened map')
  console.log(unflattened)
  for (const language in unflattened) {
    const obj = unflattened[language]
    const yaml = jsyaml.safeDump(obj, {
      lineWidth: -1,
      noCompatMode: true,
    })
    fs.writeFileSync(`${__dirname}/../locales/${language}.yaml`, yaml)
  }
  console.log('==== Saved object to the file')

  console.log('==== Working on errors')
  const errorTranslations = (
    await axios.get('https://localizer.todomaster.com/localizations?tag=telegram')
  ).data.filter((l) => {
    return l.tags.indexOf('errors') > -1
  })
  console.log(JSON.stringify(errorTranslations, undefined, 2))
  const errorsMap = {}
  for (const translation of errorTranslations) {
    const key = translation.key.replace('error.', '')
    const value = errorsMap[key] || {}
    for (const variant of translation.variants) {
      if (!variant.selected) {
        continue
      }
      value[variant.language] = variant.text
    }
    errorsMap[key] = value
  }
  fs.writeFileSync(
    `${__dirname}/../locales/errors.js`,
    `module.exports = ${JSON.stringify(errorsMap, undefined, 2)}`
  )
})()
