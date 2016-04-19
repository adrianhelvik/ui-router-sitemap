shallowClone = require './shallowClone'
fs = require 'fs'

createStateObjects = (file, cb) ->
    fs.readFile file, 'utf8', (err, content) ->
        if err?
            return cb err
        states = {}
        nesting =
            curlies: 0
            square: 0
            parens: 0
        current = ''
        isNextState = no
        parsingState = no
        content.split('').forEach (letter) ->
            # Nesting
            if letter is '{'
                nesting.curlies++
            if letter is '}'
                nesting.curlies--
            if letter is '('
                nesting.parens++
            if letter is ')'
                nesting.parens--
            if letter is '['
                nesting.square++
            if letter is ']'
                nesting.square--

            if parsingState
                currNesting = states[current].nesting
                if not states[current].hasStarted
                    if letter is '{'
                        states[current].hasStarted = yes
                    else return
                states[current].data += letter
                if currNesting.curlies < nesting.curlies
                    return
                else
                    delete states[current].nesting
                    parsingState = no
                    current = ''
                    return

            if not /[.a-zA-Z0-9]/.test letter
                if /^[a-zA-Z0-9_$.]+$/.test(current) and isNextState
                    states[current] =
                        nesting: shallowClone nesting
                        data: ''
                        hasStarted: no
                    parsingState = yes
                    isNextState = no
                    return

                if current is '.state'
                    isNextState = yes

                return current = ''

            current += letter

        Object.keys states
            .forEach (state) ->
                states[state] = new Function('return ' + states[state].data + ';')()

        cb null, states

module.exports = createStateObjects
