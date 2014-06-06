var mongoose = require('mongoose');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var BookPopulation = require('./BookPopulation');


module.exports.populate = function(categories,finished) {
	
	console.log("populating categories");
	console.log(categories)
	
	var Category = mongoose.model('Category', CategorySchema.schema)
	
	var results = []
	var numItems = categories.length;
	
	var categoryFinished = function() {
		numItems--;
		console.log("category finished: " + numItems);
		if (numItems<=0) {
			finished(results);
		}
	};
	
	categories.forEach(function(unpopulated) {
			
		console.log("Populate category");

		Category.populate(unpopulated,{ path: "books" }).then(function(unpopulated) {
			
			console.log("category populated")
			
			var numRelated = 0
			
			var populated = {}
			populated.id = unpopulated.id
			populated.title = unpopulated.title
			results.push(populated)

			var itemFinished = function() {
				numRelated--;
				console.log("book finished: " + numRelated);
				if (numRelated<=0) {
					categoryFinished();					
				}
			}
			
			if ( (unpopulated.books instanceof Array) && (unpopulated.books.length>0) ) {
				console.log("Populate books")
				
				numRelated++;
				BookPopulation.populate(unpopulated.books,function(books) {
					populated.books = books;
					itemFinished();					
				});
			}
			else {
				var Book = mongoose.model('Book', BookSchema.schema)
				console.log("Find books")
				Book.find({ category: unpopulated.id }).exec(function (err, items) {
					numRelated++;
					
					console.log("Populate books")
					
					if (err) {
						res.send({"result": "1", "errorMessage":err.message});
					}
					else {
						BookPopulation.populate(items,function(books) {
							console.log("populated books")
							populated.books = books;
							console.log(books)
							itemFinished();					
						});
					}
				});
			}
		});
	});
}