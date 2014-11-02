var express = require('express');
var mysql = require('mysql');
var fs = require('fs');

var app = express();

var pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'root',
    database: 'node',
    multipleStatements: true
});

app.get('/create', function (req, res) {
    fs.readFile(__dirname + '/create.sql', 'utf8', function (err, file) {
        if (err) throw err;

        pool.query(file, function (err, rows, fields) {
            if (err) throw err;

            console.log(rows);
        });
    });
});

var server = app.listen(4000, function () {
    console.log('Listening on port %d', server.address().port);
});