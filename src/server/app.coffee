traktor = require("./traktor").setBaseDir __dirname

###
    Main application class
###
class App
  require: [
      'http'
      'express'
      'backbone'
      'backbone-sql as backboneSql'
      'body-parser as bodyParser'

      './config'
    ]

  modules:
    './accounts': ''

  app: null

  ###
    Routes
  ###
  get: []

  post: []

  init: ->
    @app = @express()
    @app.use @express.static "#{__dirname}/../public/"
    @app.use @bodyParser.json {}
    @server = @http.Server @app

  ###
    Final init after traktor modules
  ###
  final: ->
    @server.listen @config.SERVER.PORT, =>
      console.log "\n\nRunning on port :#{@config.SERVER.PORT} | Started time: " + (Date.now() % 1000)

###
  Run App class
###
traktor App