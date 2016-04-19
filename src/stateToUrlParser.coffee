glob = require 'glob'
async = require 'async'
flatten = require './flatten'
createStateObjects = require './createStateObjects'
countChar = require './countChar'
resolveChildStates = require './resolveChildStates'

stateToUrlParser = (paths, complete) ->
    findFiles = (cb) ->
        globFiles = (path, cb) ->
            glob path, (err, files) ->
                cb err, files

        async.map paths, globFiles, (err, result) ->
            cb null, flatten result

    parseFiles = (files, cb) ->
        async.map files, createStateObjects, (err, stateObjects) ->
            if err?
                return cb err

            result = {}

            for stateList in stateObjects
                for name, state of stateList
                    result[name] = state

            cb null, result

    async.waterfall [findFiles, parseFiles, resolveChildStates], complete

module.exports = stateToUrlParser
