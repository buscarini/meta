var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);

var CoverPopulation = require('./CoverPopulation');

module.exports.populate = function(books,finished) {
	
	var Book = mongoose.model('Book', BookSchema.schema)
	
	var results = []
	var numItems = books.lenght;
	
	books.forEach(function(unpopulated) {
		Book.populate(unpopulated,{ path: "books" }).then(function(unpopulated) {
			var populated = {}
			
			var numRelated = 0;

			populated.id = unpopulated.id
			populated.title = unpopulated.title
			populated.author = unpopulated.author
			populated.numPages = unpopulated.numPages
			populated.purchaseDate = unpopulated.purchaseDate
			populated.deleted = unpopulated.deleted
		
			numRelated++;
					
			CoverPopulation.populate(unpopulated.cover,function() {
				results.push(unpopulated)
				itemFinished();
			});
			
			var itemFinished = function() {
				numRelated--;
				finished();
			}
		});
	});
	
	var finished = function() {
		numItems--;
		if (numItems==0) {
			finished(results);
		}
	};
}