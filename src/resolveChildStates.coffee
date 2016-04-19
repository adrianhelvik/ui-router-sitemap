resolveChildStates = (states, cb) ->
    stateToUrl = {}
    deferred = {}
    noUrl = {}
    nonAbstractNoUrl = []

    # Map state -> url

    # Recursively strip away .'s
    dotCount = 0

    Object.keys(states).forEach (name) ->
        state = states[name]

        # Store non-nested states
        if name.indexOf('.') is -1
            if not state.url
                if not state.abstract
                    nonAbstractNoUrl.push name
                noUrl[name] = state
                state.url = ''
            return stateToUrl[name] = state.url

        # Store nested states
        stateList = name.split '.'
        concatedName = stateList[0]
        concatedUrl = states[concatedName].url || ''

        for i in [1..stateList.length-1]
            listed = stateList[i]

            if not stateToUrl[concatedName]?
                throw new Error "Parent state of #{concatedName} not defined"

            # Add leading dot
            concatedName += '.' + listed

            concatedUrl += states[concatedName].url
            stateToUrl[concatedName] = concatedUrl

    # Delete abstract states and states with no url
    for name of stateToUrl
        if noUrl[name] or states[name].abstract
            delete stateToUrl[name]

    cb null, { stateToUrl, noUrl: nonAbstractNoUrl }

module.exports = resolveChildStates
