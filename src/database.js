const mysql = require('mysql');

/*const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'company',
    multipleStatements: true
});*/

const mysqlConnection = mysql.createConnection({
    host: 'u3r5w4ayhxzdrw87.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
    user: 'qt5rdb6zrw0y7hob',
    password: 'kws747tb4mx8j69x',
    database: 'raxuj2f1bl50ik7x',
    multipleStatements: true
});

mysqlConnection.connect(function(err) {
    if (err) {
        console.error(err);
        return;
    } else {
        console.log('db is connected');
    }
});

module.exports = mysqlConnection;