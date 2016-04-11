module = new Triangle MODULE.ACCOUNTS_PROVIDER, []

###
  Accounts model
###
class AccountModel extends Backbone.Model
  urlRoot: "/accounts"
  sync: BackboneHTTP.sync AccountModel

###
  Accounts collection
###
class AccountsCollection extends Backbone.Collection
  model: AccountModel
  sync: BackboneHTTP.sync AccountsCollection

###
  Accounts factory
###
module.factory FACTORY.ACCOUNTS,
  application:
    selectedAccount: null
    loadingErrorMessage: null

  model:
    accounts: null

  getRandomNumber: (min, max, withZero)->
    unless max?
      max = min
      min = 0
    res = Math.floor(Math.random() * (max - min + 1)) + min
    return if withZero and res<10 then "0#{res}" else res

  getRandomName: ->
    firstName: NAMES[@getRandomNumber(NAMES.length-1)].split(' ')[0]
    lastName: NAMES[@getRandomNumber(NAMES.length-1)].split(' ')[1]

  addAccount: ->
    name = @getRandomName()
    @application.selectedAccount = new AccountModel
      firstName: name.firstName
      lastName: name.lastName
      mail: "#{name.firstName}#{name.lastName}@gmail.com"
      birthDate: "#{@getRandomNumber(1950, 2000)}-#{@getRandomNumber(1, 12, 'withZero')}-#{@getRandomNumber(1, 28, 'withZero')}"

  saveAccount: ->
    return unless @application.selectedAccount?
    @model.accounts.add @application.selectedAccount if @application.selectedAccount.isNew()
    @application.selectedAccount.save()
    @application.selectedAccount = null

  removeAccount: (account)->
    account.destroy()
    
  editAccount: (account)->
    @application.selectedAccount = account
    
  onAccountsModelLoaded: (err, accounts)->
    if err
      @application.loadingErrorMessage = err.toString()
    else
      @model.accounts.reset accounts

  init: ->
    @model.accounts = new AccountsCollection()
    AccountModel.find {}, @onAccountsModelLoaded
