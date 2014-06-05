var mongoose = require('mongoose');


var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);

module.exports.populate = function(covers,finished) {
	
	var Cover = mongoose.model('Cover', CoverSchema.schema)
	
	var results = []
	
	if (!(covers instanceof Array)) covers = [covers]

	var numItems = covers.length;
	
	var coverFinished = function() {
		numItems--;
		console.log("finished " + numItems + " covers");
		if (numItems==0) {
			finished(results);
		}
	};
	
	covers.forEach(function(unpopulated) {
		var populated = {}
		populated.id = unpopulated.id
		populated.imageUrl = unpopulated.imageUrl
		
		results.push(populated)
		coverFinished();
	});
}