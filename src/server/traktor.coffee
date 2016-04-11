HTTP_METHODS = ['get', 'post', 'put', 'delete']
baseDir = __dirname

camelCase = (s)->
    s = if s.trim() then s.replace(/[^_a-zA-Z0-9\s\-]*/g, '', s) else ''
    if s then s.replace(///([_\-\s])([a-z])///g, (t, a, b)->b.toUpperCase()) else ''

snakeCase = (s)->
    s = if s.trim() then s.replace(///[^a-zA-Z0-9]///g, '_', s) else ''
    if s then s.replace(///^_+|_+$///g, '') else ''

getModule = (module)->
    module = module.split(' as ').map (part)->part.trim()
    path: if module[0].indexOf('/') >= 0 then "#{baseDir}/#{module[0]}" else module[0]
    name: if module[1]? then module[1] else module[0].split('/').slice(-1)[0]

getArrayFromString = (str)->
    return str.map((item)->item.trim()) if typeof str is 'object'
    str.split(',').map((item)->item.trim())

extend = (destination, source)->
    for key, val of source
        destination[key] = val
    destination

Traktor = (traktorClass, params)->
    params ||= {}

    traktor = new traktorClass()

    for key, func of traktor #when key isnt 'app'
        traktor[key] = traktor[key].bind traktor if typeof func is 'function'

    traktor = extend(traktor, params)

    traktor.require ||= []
    traktor.modules ||= {}

    traktor.require.forEach (item)->
        item = getModule item
        traktor[item.name] = require item.path

    traktor.init() if typeof traktor.init is 'function'

    if traktor.app?
        traktor.app.baseDir = baseDir
        HTTP_METHODS.forEach (method)->
            if typeof traktor[method] is 'object' and traktor[method].forEach?
                traktor[method].forEach (rawParams)->
                    middleware = rawParams[1..-2]
                    middleware = getArrayFromString middleware if middleware.length is 1
                    middleware = (traktor[item] for item in middleware when traktor[item]?)
                    callback = rawParams[-1..][0]
                    callback = if typeof callback is 'function' then callback.bind(traktor) else traktor[callback]
                    traktor.app[method] rawParams[0], middleware..., callback

    for req, injects of traktor.modules
        module = getModule req
        params = {}
        getArrayFromString(injects).forEach (key)->params[key] = traktor[key]
        params.app = traktor.app if traktor.app?
        traktor[module.name] = Traktor (require module.path), params

    traktor.final() if typeof traktor.final is 'function'

    traktor

Traktor.setBaseDir = (dir)->
    baseDir = dir
    Traktor

module.exports = Traktor
