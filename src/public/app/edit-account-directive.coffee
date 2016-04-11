module = new Triangle MODULE.EDIT_ACCOUNT_DIRECTIVE, [
  MODULE.ACCOUNTS_PROVIDER
]

###
  User add\edit directive
###
module.directive 'editAccount',
  restrict: Triangle.DIRECTIVE_TYPE.ELEMENT
  templateUrl: 'jsEditAccountTemplate'
  inject: [FACTORY.ACCOUNTS]
  local:
    scope:
      application: FACTORY.ACCOUNTS
      saveAccount: FACTORY.ACCOUNTS
      close: LOCAL_METHOD

    close: ->
      @application.selectedAccount = null

  link: ->
