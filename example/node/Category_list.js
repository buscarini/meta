var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var schema = require('./CategorySchema');
schema.schema.set('autoIndex', false);

var categoryPopulation = require('./CategoryPopulation')

module.exports.findOne = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', schema.schema)

	Category.find({
		_id : req._id
	},function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			var contentObject = { "result" :"0" }
			
			categoryPopulation.populate(items,function(populated) {
				contentObject.categories = populated;
				res.send(contentObject);
				if (callback) callback()
			});
		}
	})
};

module.exports.findAll = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', schema.schema)
	var Book = mongoose.model('Book', booksSchema.schema);

	Category.find({
	})
	.sort({  id : 1  })
	.populate('books')
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.errmsg});
		}
		else {
			
			var contentObject = { "result" :"0" }

			console.log("populate categories");
			
			categoryPopulation.populate(items,function(populated) {
				console.log("categories populated");
				
				contentObject.categories = populated;
				res.send(contentObject);
				if (callback) callback()
			});
		}
	})
};
