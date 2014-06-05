var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);


module.exports.findOneCategory = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', CategorySchema.schema)

	Category.find({
		_id : req._id
	})
	//.populate('')
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			contentObject = { "result" :"0" };
			contentObject.categories = new Array();
			
			var sendResponse = function(err) {
				res.send(contentObject);
					
				if (callback) callback();
			};
			
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					sendResponse(err);
				}
			};
			
			items.forEach(function(unpopulated) {
				var populated = {}
				populated.id = unpopulated._id
				populated.title = unpopulated.title

				content.categories.push(populated);
				//
			})
		}
	})
};
module.exports.findOneBook = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Book = mongoose.model('Book', BookSchema.schema)
	var Category = mongoose.model('Category', CategorySchema.schema)

	Book.find({
		_id : req._id,
		deleted : { $eq: false }
	})
	//.populate('category')
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			contentObject = { "result" :"0" };
			contentObject.books = new Array();
			
			var sendResponse = function(err) {
				res.send(contentObject);
					
				if (callback) callback();
			};
			
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					sendResponse(err);
				}
			};
			
			items.forEach(function(unpopulated) {
				var populated = {}
				populated.id = unpopulated._id
				populated.title = unpopulated.title
				populated.author = unpopulated.author
				populated.numPages = unpopulated.numPages
				populated.purchaseDate = moment(unpopulated.purchaseDate).format("DD.MM.YYYY")
				populated.deleted = unpopulated.deleted

				var promise = Category.populate(unpopulated,{ path: "" });
				var relatedUnpopulated = unpopulated.category;
				var relatedPopulated = {};
				populated.category = relatedPopulated;
				populated.id = unpopulated._id

				finished(null);
				content.books.push(populated);
				//
			})
		}
	})
};

module.exports.findAll = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');
	
	var numFinds = 0;
	var contentObject = {};
		
	var foundFunction = function(err) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			numFinds--;
			if (numFinds>0) return;
			
			contentObject.result = "0";
			
			res.send(contentObject);
					
			if (callback) callback();
		}
	};
	
	numFinds++;
	
	var Category = mongoose.model('Category', CategorySchema.schema)

	Category.find({
	})
	.sort({  id : 1  })
	// .populate('')
	.exec(function (err, items) {
		if (!err) {
			contentObject.categories = new Array();
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					foundFunction(err);
				};
			};
			
			items.forEach(function(unpopulated) {
				var populated = {}
				populated.id = unpopulated._id
				populated.title = unpopulated.title

				contentObject.categories.push(populated);
			})
		}
	})
	
	numFinds++;
	
	var Book = mongoose.model('Book', BookSchema.schema)
	var Category = mongoose.model('Category', CategorySchema.schema)

	Book.find({
		deleted : { $eq: false }
	})
	.sort({  id : 1  })
	// .populate('category')
	.exec(function (err, items) {
		if (!err) {
			contentObject.books = new Array();
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					foundFunction(err);
				};
			};
			
			items.forEach(function(unpopulated) {
				var populated = {}
				populated.id = unpopulated._id
				populated.title = unpopulated.title
				populated.author = unpopulated.author
				populated.numPages = unpopulated.numPages
				populated.purchaseDate = moment(unpopulated.purchaseDate).format("DD.MM.YYYY")
				populated.deleted = unpopulated.deleted

				var promise = Category.populate(unpopulated,{ path: "" });
				var relatedUnpopulated = unpopulated.category;
				var relatedPopulated = {};
				populated.category = relatedPopulated;
				populated.id = unpopulated._id

				finished(null);
				contentObject.books.push(populated);
			})
		}
	})
	
};
