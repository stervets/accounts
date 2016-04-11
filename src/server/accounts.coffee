config = require './config'
backbone = require 'backbone'
backboneSql = require 'backbone-sql'
backboneRest = require 'backbone-rest'
console.log config.mysqlUrl
###
  Accounts model
###
class AccountsModel extends backbone.Model
  urlRoot: "#{config.mysqlUrl}/accounts"
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
  resetTable: ->
    db = AccountsModel.db()
    db.ensureSchema (err) =>
      console.log err if err
      db.resetSchema (err) ->console.log err if err

  init: ->
    #@resetTable()
    @controller = new backboneRest @app,
      model_type: AccountsModel
      route: '/accounts'

module.exports = Accounts