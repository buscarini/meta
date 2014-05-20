// var fs = require('fs');
var csv = require('csv');
var mongoose = require('mongoose');
var express = require('express');
var bookImporter = require('./BookImporter')
var Book_list = require('./Book_list')
var categoryImporter = require('./CategoryImporter')
var Category_list = require('./Category_list')
var fs = require('fs')
	
var app = express();

var booksCSVFile = __dirname+"/books.csv";
var categoriesCSVFile = __dirname+"/categories.csv";

app.get('/import', function(req, res) {

	var numTasks = 2;
	
	var finished = function(response) {
		if (numTasks>0) return;
		res.send(response);
	}
	
	bookImporter.importFile(booksCSVFile,function(err,books) {

		var response = ''
		
		if (!err) {
			books.forEach(function(book) {
				response = response + book.id + " " + book.title + "</br>"
			});
		}
		
		numTasks--;
		finished(response);
	})
	
	categoryImporter.importFile(categoriesCSVFile,function(err,categories) {

		var response = ''
		
		if (!err) {
			categories.forEach(function(category) {
				response = response + category.id + " " + category.title + "</br>"
			});
		}
		
		numTasks--;
		finished(response);
	})
})

fs.watchFile(booksCSVFile, function(curr,prev) {
	console.log("watching file")
	if (prev.mtime.getTime()!=curr.mtime.getTime()) {
		console.log("importing csv")
		importer.importFile(booksCSVFile,function(err,books) {
			if (err) {
				console.log(err);
			}
		});		
	}
});

fs.watchFile(categoriesCSVFile, function(curr,prev) {
	console.log("watching file")
	if (prev.mtime.getTime()!=curr.mtime.getTime()) {
		console.log("importing csv")
		importer.importFile(categoriesCSVFile,function(err,books) {
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

app.get('/categories', function(req, res) {
	Category_list.findAll(req,res,function() {
	})
})


var server = app.listen(3000, function() {
		
	mongoose.connect('mongodb://localhost/test')
		
    console.log('Listening on port %d', server.address().port);
});
