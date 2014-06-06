var mongoose = require('mongoose');

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);

var CoverPopulation = require('./CoverPopulation');

module.exports.populate = function(books,finished) {
	
	var Book = mongoose.model('Book', BookSchema.schema)
	var Cover = mongoose.model('Cover', CoverSchema.schema)
	
	var results = []
	var numItems = books.length;
	console.log("books to populate: " + numItems)
	
	var booksFinished = function() {
		numItems--;
		console.log("finished " + numItems + " books");
		if (numItems<=0) {
			finished(results);
		}
	};
	
	books.forEach(function(unpopulated) {
		
		Book.populate(unpopulated,{ path: "cover" }).then(function(unpopulated) {
			
			var populated = {}
			
			var numRelated = 0;

			populated.id = unpopulated.id
			populated.title = unpopulated.title
			populated.author = unpopulated.author
			populated.numPages = unpopulated.numPages
			populated.purchaseDate = unpopulated.purchaseDate
			populated.deleted = unpopulated.deleted
			
			results.push(populated)
		
			numRelated++;
			
			var itemFinished = function() {
				numRelated--;				
				if (numRelated<=0)	{
					booksFinished();
				}
			}
						
			CoverPopulation.populate(unpopulated.cover,function(covers) {
				populated.cover = covers[0]
				itemFinished();
			});
		});
	});
}