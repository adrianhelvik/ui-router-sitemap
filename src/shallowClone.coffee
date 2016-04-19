module.exports = (obj) ->
    res = {}
    for key, val of obj
        res[key] = val
    return res
