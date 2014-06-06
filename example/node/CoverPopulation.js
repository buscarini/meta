var mongoose = require('mongoose');

var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);


module.exports.populate = function(items,finished) {
	
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

		Cover.populate(unpopulated,{ path: "" }).then(function(unpopulated) {
						
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
			
			
			if (numRelated<=0) {
				modelItemFinished();					
			}
		});		
	});
}
