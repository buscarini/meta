var fs = require('fs');
var mongoose = require('mongoose');
var csv = require('csv');
var schema = require('./BookSchema')
var moment = require('moment');

module.exports.importFile = function(filePath,callback) {
	
	var Book = mongoose.model('Book', schema.schema)
	
	csv()
	.from.path(filePath, { delimiter: ';', escape: '"' })
	.on('record', function(row,index) {
	
		var properties = {}
		if (row.length>0) properties.id = row[0]
		if (row.length>1) properties.title = row[1]
		if (row.length>2) properties.author = row[2]
		if (row.length>3) properties.numPages = row[3]
		if (row.length>4) properties.purchaseDate = moment(row[4],"DD/MM/YYYY")
		properties.deleted = false
		if (row.length>5) properties.deleted = row[5]
	
		Book.update({ 
			id : row[0],
		}, properties,{ upsert: true, multi: true },function(err) {
			if (err) {
				console.log("Error updating Book: " + err)
			}
		})
	})
	.on('end', function(count) {
		
		Book.find(function (err, items) {
			if (callback) {
				callback(err,items);
			}
		})
	})
	.on('error', function(error){
		console.log(error.message);
		if (callback) callback(error);
	});
	
}