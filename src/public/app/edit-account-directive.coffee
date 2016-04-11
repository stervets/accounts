module = new Triangle MODULE.EDIT_ACCOUNT_DIRECTIVE, [
  MODULE.ACCOUNTS_PROVIDER
]

###
  User add\edit directive
###
module.directive 'editAccount',
  restrict: Triangle.DIRECTIVE_TYPE.ELEMENT
  templateUrl: 'jsEditAccountTemplate'
  inject: [FACTORY.ACCOUNTS, '$timeout']
  local:
    scope:
      application: FACTORY.ACCOUNTS
      saveAccount: FACTORY.ACCOUNTS
      save: LOCAL_METHOD
      close: LOCAL_METHOD
      form: LOCAL_PROPERTY

    form:
      showError: false
      account: null

    onApplicationSelectedAccountCidChange: ->
      if @application.selectedAccount?.cid
        @form.account = @application.selectedAccount.toJSON()
        @$timeout (=>
          @form.showError = true
        ), 1000
      else
        @form.showError = false

    watch:
      'application.selectedAccount.cid': 'onApplicationSelectedAccountCidChange'

    save: ->
      @application.selectedAccount.set @form.account
      @saveAccount()

    close: ->
      @application.selectedAccount = null

  link: ->
