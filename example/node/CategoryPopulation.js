
var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var BookPopulation = require('./BookPopulation');


module.exports.populate = function(categories,finished) {
	
	var Category = mongoose.model('Category', CategorySchema.schema)
	
	var results = []
	var numItems = categories.length;
	
	categories.forEach(function(unpopulated) {
		Category.populate(unpopulated,{ path: "books" }).then(function(unpopulated) {
			
			var numRelated = 0
			
			var populated = {}
			populated.id = unpopulated.id
			populated.title = unpopulated.title
			
			if (unpopulated.books instanceof Array) {
				numRelated += unpopulated.books.length;
				BookPopulation.populate(unpopulated.books,function() {
					results.push(unpopulated)
					itemFinished();					
				});
			}
			
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