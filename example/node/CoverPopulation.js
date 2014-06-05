var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);

module.exports.populate = function(covers,finished) {
	
	var Cover = mongoose.model('Cover', CoverSchema.schema)
	
	var results = []
	var numItems = covers.lenght;
	
	covers.forEach(function(unpopulated) {
		var populated = {}
		populated.id = unpopulated.id
		populated.url = unpopulated.url
		
		results.push(unpopulated)
		finished();
	});
	
	var finished = function() {
		numItems--;
		if (numItems==0) {
			finished(results);
		}
	};
}