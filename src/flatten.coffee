###
# Flatten an array of arrays of arrays of...
###
flatten = (array) ->
    if not Array.isArray array
        return [array]

    result = []
    array.forEach (item) ->
        flatten(item).forEach (subItem) ->
            result.push subItem
    return result

module.exports = flatten
