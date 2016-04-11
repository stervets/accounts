app = new Triangle @APPLICATION_NAME, [
  'ngAnimate'
  'datatables'
  'ui.bootstrap.datetimepicker'
  MODULE.ACCOUNTS_PROVIDER
  MODULE.EDIT_ACCOUNT_DIRECTIVE
]

###
   Application main controller
###
app.controller 'MainController',
  inject: [FACTORY.ACCOUNTS]
  local:
    scope:
      model: FACTORY.ACCOUNTS
      application: FACTORY.ACCOUNTS
      addAccount: FACTORY.ACCOUNTS
      removeAccount: FACTORY.ACCOUNTS
      editAccount: FACTORY.ACCOUNTS
      remove: LOCAL_METHOD

    remove: (account)->
      @removeAccount account if confirm "Remove #{account.get('firstName')} #{account.get('lastName')}?"