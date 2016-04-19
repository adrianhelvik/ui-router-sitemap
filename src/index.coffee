stateToUrlParser = require './stateToUrlParser'
async = require 'async'
createSiteMap = require './createSiteMap'

module.exports = (domain, paths, complete) ->

    # parse state -> url
    parseStates = (cb) ->
        stateToUrlParser paths, (err, data) ->
            if err?
                return cb err
            {noUrl, stateToUrl} = data

            cb null, stateToUrl

    # Separate out urls with parameters
    separateParamUrls = (stateToUrl, cb) ->
        withParams = {}
        noParams = {}

        for state, url of stateToUrl
            if url.indexOf(':') isnt -1 or url.indexOf('{') isnt -1
                withParams[state] = url
            else noParams[state] = url

        cb null, withParams, noParams

    # parse xml
    parseXml = (withParams, noParams, cb) ->
        createSiteMap domain, noParams, (err, xmlString) ->
            if err?
                return cb err
            cb null, xmlString, withParams

    async.waterfall [parseStates, separateParamUrls, parseXml], complete
