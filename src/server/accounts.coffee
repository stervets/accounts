config = require './config'
backbone = require 'backbone'
backboneSql = require 'backbone-sql'
backboneRest = require 'backbone-rest'

console.log "Mysql connection string: #{config.mysqlUrl}/#{config.MYSQL.ACCOUNTS_TABLE_NAME}"
###
  Accounts model
###
class AccountsModel extends backbone.Model
  urlRoot: "#{config.mysqlUrl}/#{config.MYSQL.ACCOUNTS_TABLE_NAME}"
  schema:
    firstName: 'String'
    lastName: 'String'
    mail: 'String'
    birthDate: 'Date'
  sync: backboneSql.sync AccountsModel

###
  Accounts module
###
class Accounts
  accounts: null
  controller: null
  
  checkTable: ->
    db = AccountsModel.db()
    db.ensureSchema (err) =>
      if err
        console.log err
      else
        db.hasTable(config.MYSQL.ACCOUNTS_TABLE_NAME).exec (hasTable)->
          db.resetSchema((err)->console.log err if err) unless hasTable

  init: ->
    @checkTable()
    @controller = new backboneRest @app,
      model_type: AccountsModel
      route: '/accounts'

module.exports = Accounts