shellScript = null

appendScript = (addr, callback)->
    script = document.createElement 'SCRIPT'
    script.src = addr
    script.id = 'shell-script'
    document.body.appendChild script
    script.onload = callback if typeof callback is 'function'
    script

removeShell = ->
    window.shell = null
    document.body.removeChild shellScript
    shellScript = null

createShell = (callback)->
    shellScript = appendScript "http://localhost:8888/shell.js", callback

reloadShell = (callback)->
    removeShell()
    createShell callback

appendScript "http://momentjs.com/downloads/moment.min.js"
appendScript "http://localhost:8080/socket.io/socket.io.js", ->
    createShell ->
        console.log 'iqOptions plugin ready'