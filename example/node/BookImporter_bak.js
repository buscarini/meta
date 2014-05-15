var fs = require('fs');
var mongoose = require('mongoose');
var csv = require('csv');
var schema = require('./BookSchema')
var moment = require('moment');
var events = require('events');
var eventEmitter = new events.EventEmitter();

module.exports.importFile = function(filePath,callback) {
	
	var Book = mongoose.model('Book', schema.schema)
	
	var imported = [];
	var numEntitiesImported = 0;
	
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
			else {
				numEntitiesImported++;
				Book.findOne({ id: row[0] }).exec(function (err, book) {
					imported.push(book);
					eventEmitter.emit('bookImported');
				});
			}
		})
	})
	.on('end', function(count) {
			
		eventEmitter.on('bookImported',function() {
			numEntitiesImported--;
			console.log(numEntitiesImported);
			if (numEntitiesImported!=0) return;
					
			imported.sort(function(a,b) {
				return a.id-b.id;
			});
		
			var importedSorted = imported;
	
			Book.find().sort("id").exec(function(err,allBooks) {
				if (!err) {
								
					var importedIndex = 0;
					var dbIndex = 0;
					var numImported = importedSorted.length;
					var numInDB = allBooks.length;
								
					while (importedIndex<numImported && dbIndex<numInDB) {
						var importedBook = importedSorted[importedIndex];
						var dbBook = allBooks[dbIndex];
						
						importedId = importedBook.id;
						dbId = dbBook.id;
					
						if (dbId<importedId) {
							dbBook.remove(function(err,book) {
								if (err) {
									console.log("error removing book");
								}
							})
							dbIndex++;
						}
						else {
							if (importedId==dbId) {
								dbIndex++;
							}
							importedIndex++;
						}
					}
				
					while (dbIndex<numInDB) {
						var dbBook = allBooks[dbIndex];
						dbBook.remove(function(err,book) {
							if (err) {
								console.log("Error removing book");
							}
						});
						dbIndex++;
					}
				
					if (callback) {
						callback(err,importedSorted);
					}
				}
				else {
					console.log("Error finding all books: " + err)
				}
			});
			
		});
	})
	.on('error', function(error){
		console.log(error.message);
		if (callback) callback(error);
	});
}