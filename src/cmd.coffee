argv = require('yargs')
    .demand('domain')
    .argv

files = argv._
domain = argv.domain

console.log 'Files:', files
console.log 'Domain:', domain

uiSitemaps = require './index'

uiSitemaps domain, files, (err, sitemap, withParams) ->
    if err?
        throw err

    console.log '--- sitemap ---'
    console.log ''
    console.log sitemap
    console.log ''
    console.log '--- states/urls with params ---'
    console.log withParams
