var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);
var categorySchema = require('./CategorySchema');
categorySchema.schema.set('autoIndex', false);


module.exports.findOneCategory = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', CategorySchema.schema)

	Category.find({
		_id : req._id
	})
	.populate('')
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
			
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title



			})
		}
	})
};
module.exports.findOneBook = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Book = mongoose.model('Book', BookSchema.schema)
	var Category = mongoose.model('Category', categorySchema.schema);

	Book.find({
		_id : req._id,
		deleted : { $eq: false }
	})
	.populate('category')
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
			
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.author = item.author
				serviceItem.numPages = item.numPages
				serviceItem.purchaseDate = moment(item.purchaseDate).format("DD.MM.YYYY")
				serviceItem.deleted = item.deleted

				var populated = item.category;
				var related = {};
				related.id = populated._id;
				serviceItem.category = related;
				contentObject.books.push(serviceItem);
				finished(null);


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
	.populate('')
	.exec(function (err, items) {
		if (!err) {
			contentObject.categories = new Array();
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					foundFunction(err);
				}
			};
			
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title



			})
		}
	})
	
	numFinds++;
	
	var Book = mongoose.model('Book', BookSchema.schema)
	var Category = mongoose.model('Category', categorySchema.schema);

	Book.find({
		deleted : { $eq: false }
	})
	.sort({  id : 1  })
	.populate('category')
	.exec(function (err, items) {
		if (!err) {
			contentObject.books = new Array();
			var numOps = items.length;
			var finished = function(error) {
				numOps--;
				if (numOps==0) {
					foundFunction(err);
				}
			};
			
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.author = item.author
				serviceItem.numPages = item.numPages
				serviceItem.purchaseDate = moment(item.purchaseDate).format("DD.MM.YYYY")
				serviceItem.deleted = item.deleted

				var populated = item.category;
				var related = {};
				related.id = populated._id;
				serviceItem.category = related;
				contentObject.books.push(serviceItem);
				finished(null);


			})
		}
	})
	
};
