var moment = require('moment');
var mongoose = require('mongoose');

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);

var CoverPopulation = require('./CoverPopulation');

module.exports.populate = function(items,finished) {
	
	var Book = mongoose.model('Book', BookSchema.schema)
	
	var Cover = mongoose.model('Cover', CoverSchema.schema)
	
	
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

		Book.populate(unpopulated,{ path: "cover" }).then(function(unpopulated) {
						
			var numRelated = 0
			
			var populated = {}
			populated.id = parseInt(unpopulated.id,10)
			populated.title = unpopulated.title
			populated.author = unpopulated.author
			populated.numPages = parseInt(unpopulated.numPages,10)
			populated.purchaseDate = moment(unpopulated.purchaseDate).format("DD.MM.YYYY")
			populated.deleted = unpopulated.deleted
			results.push(populated)

			var itemFinished = function() {
				numRelated--;
				if (numRelated<=0) {
					modelItemFinished();					
				}
			}
			
			
			numRelated++;
					
			CoverPopulation.populate(unpopulated.cover,function(relatedItems) {
				populated.cover = relatedItems[0]
				itemFinished();
			});
			
			
			if (numRelated<=0) {
				modelItemFinished();					
			}
		});		
	});
}
