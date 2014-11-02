var express = require('express');
var mysql = require('mysql');
var fs = require('fs');
var config = require('./config.js')

var app = express();

var pool = mysql.createPool(config.db);

app.get('/create', function (req, res) {
    fs.readFile(__dirname + '/create.sql', 'utf8', function (err, file) {
        if (err) throw err;

        pool.query(file, function (err, rows, fields) {
            if (err) throw err;

            console.log(rows);
            res.json(rows);
        });
    });
});

var server = app.listen(4000, function () {
    console.log('Listening on port %d', server.address().port);
});