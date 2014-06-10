var moment = require('moment');
var mongoose = require('mongoose');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var BookPopulation = require('./BookPopulation');

module.exports.populate = function(items,finished) {
	
	var Category = mongoose.model('Category', CategorySchema.schema)
	
	var Book = mongoose.model('Book', BookSchema.schema)
	
	
	var results = []
	
	if (!(items instanceof Array)) items = [items]
	
	var numItems = items.length;
	
	var modelItemFinished = function() {
		numItems--;
		if (numItems<=0) {
			finished(results);
		}
	};
	
	items.forEach(function(unpopulated) {

		Category.populate(unpopulated,{ path: "books" }).then(function(unpopulated) {
						
			var numRelated = 0
			
			var populated = {}
			populated.id = parseInt(unpopulated.id,10)
			populated.title = unpopulated.title
			results.push(populated)

			var itemFinished = function() {
				numRelated--;
				if (numRelated<=0) {
					modelItemFinished();					
				}
			}
			
			if ( (unpopulated.books instanceof Array) && (unpopulated.books.length>0) ) {				
				numRelated++;
				BookPopulation.populate(unpopulated.books,function(relatedItems) {
					populated.books = relatedItems;
					itemFinished();					
				});
			}
			else {
				var Book = mongoose.model('Book', BookSchema.schema)

				numRelated++;
				Book.find({ category: unpopulated.id }).exec(function (err, items) {	
										
					if (err) {
						res.send({"result": "1", "errorMessage":err.message});
					}
					else {
						BookPopulation.populate(items,function(relatedItems) {
							populated.books = relatedItems;
							itemFinished();					
						});
					}
				});
			}
			
			if (numRelated<=0) {
				modelItemFinished();					
			}
		});		
	});
}
