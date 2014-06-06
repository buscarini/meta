var mongoose = require('mongoose');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookPopulation = require('./BookPopulation');

module.exports.populate = function(items,finished) {
	
	var Category = mongoose.model('Category', CategorySchema.schema)
	
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

		Category.populate(unpopulated,{ path: "books " }).then(function(unpopulated) {
						
			var numRelated = 0
			
			var populated = {}
			populated.id = unpopulated.id
			populated.title = unpopulated.title
			results.push(populated)

			var itemFinished = function() {
				numRelated--;
				if (numRelated<=0) {
					modelItemFinished();					
				}
			}
			
			
			numRelated++;
					
			BookPopulation.populate(unpopulated.books,function(relatedItems) {
				populated.books = relatedItems[0]
				itemFinished();
			});
			
			
			if (numRelated<=0) {
				modelItemFinished();					
			}
		});		
	});
}
