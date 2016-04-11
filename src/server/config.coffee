@CONFIG =
  SERVER:
    PORT: '8080'

  MYSQL:
    ADDR: 'localhost:3306'
    DBNAME: 'test'
    USERNAME: 'root'
    PASSWORD: '123123'

    ACCOUNTS_TABLE_NAME: 'accounts'

@CONFIG.mysqlUrl = "mysql://#{@CONFIG.MYSQL.USERNAME}:#{@CONFIG.MYSQL.PASSWORD}@#{@CONFIG.MYSQL.ADDR}/#{@CONFIG.MYSQL.DBNAME}"
module.exports = @CONFIG