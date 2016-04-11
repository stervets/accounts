# Accounts application
Test task for Senior JavaScript Web Developer position.

### Install
##### 1. Clone application repository from github
```
    git clone https://github.com/stervets/accounts.git
    cd accounts
```
##### 2. Edit src/server/config.coffee file and set mysql database access requisites
```
    ADDR: 'localhost:3306',
    DBNAME: 'test',
    USERNAME: 'root',
    PASSWORD: '123123',
    ACCOUNTS_TABLE_NAME: 'accounts'
```
##### 3. Build project
```
    gulp build
```
##### 4. Run
```
    npm start
```

### Live demo
http://accounts.deeprest.ru

### Note
> This project uses small-known library "TriangleJS". It's not framework over framework. It's just a syntax sugar, that makes code look more OOP-styled and lets escape from angular's callback-hell.