// var fs = require('fs');
var csv = require('csv');
var mongoose = require('mongoose');
var express = require('express');
var importer = require('./BookImporter')
var Book_list = require('./Book_list')
var fs = require('fs')
	
var app = express();

var csvFile = __dirname+"/books.csv";

app.get('/import', function(req, res) {
	
	importer.importFile(csvFile,function(err,books) {

		var response = ''
		
		if (!err) {
			books.forEach(function(book) {
				response = response + book.id + " " + book.title + "</br>"
			});
		}
		
		res.send(response)
	})
})

fs.watchFile(csvFile, function(curr,prev) {
	console.log("watching file")
	if (prev.mtime.getTime()!=curr.mtime.getTime()) {
		console.log("importing csv")
		importer.importFile(csvFile,function(err,books) {
			if (err) {
				console.log(err);
			}
		});		
	}
});

app.get('/books', function(req, res) {
	Book_list.findAll(req,res,function() {
	})
})

var server = app.listen(3000, function() {
		
	mongoose.connect('mongodb://localhost/test')
		
    console.log('Listening on port %d', server.address().port);
});
