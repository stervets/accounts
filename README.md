# Accounts application
Test task for Senior JavaScript Web Developer position.

### Install
##### 1. Clone application repository from github
```
    git clone https://github.com/stervets/accounts.git
    cd accounts
```

##### 2. Install npm and bower packages
```
    npm install
    bower install -F
```
> Some npm packages may need to be installed with -g parameter

##### 3. Edit src/server/config.coffee file and set mysql database access requisites
```
    ADDR: 'localhost:3306',
    DBNAME: 'test',
    USERNAME: 'root',
    PASSWORD: '123123',
    ACCOUNTS_TABLE_NAME: 'accounts'
```
##### 4. Build project
```
    gulp build
```
##### 5. Run
```
    npm start
```

### Live demo
http://accounts.deeprest.ru

### Note
> This project uses small-known library "TriangleJS". It's not framework over framework. It's just a syntax sugar, that makes code look more OOP-styled and lets escape from angular's callback-hell.