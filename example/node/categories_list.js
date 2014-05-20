var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);
var booksSchema = require('./BookSchema');
booksSchema.schema.set('autoIndex', false);




module.exports.findOneCategory = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', CategorySchema.schema)
	var Book = mongoose.model('Book', booksSchema.schema);

	Category.find({
		_id : req._id
	})
	.populate('books')
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			
			contentObject = { "result" :"0" }
			contentObject.categories = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title

				var populated = item.books
				var related = []
				for (var index=0;index<populated.length;index++) {
					var populatedObj = populated[index]
					var relatedObj = {}

					relatedObj.id = populatedObj._id
					relatedObj.title = populatedObj.title
					relatedObj.author = populatedObj.author
					relatedObj.numPages = populatedObj.numPages
					relatedObj.purchaseDate = populatedObj.purchaseDate
					relatedObj.deleted = populatedObj.deleted

					related.push(relatedObj)
				}

				serviceItem.books = related;

				contentObject.categories.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	})
};

module.exports.findAll = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');
	
	var numFinds = 0;
	var contentObject = {}
		
	var foundFunction = function(err) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			numFinds--;
			if (numFinds>0) return;
			
			contentObject.result = "0"
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	};
	
	numFinds++;
	
	var Category = mongoose.model('Category', CategorySchema.schema)
	var Book = mongoose.model('Book', booksSchema.schema);

	Category.find({
	})
	.sort({  id : 1  })
	.populate('books')
	.exec(function (err, items) {
		if (!err) {
			contentObject.categories = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title

				var populated = item.books
				var related = []
				for (var index=0;index<populated.length;index++) {
					var populatedObj = populated[index]
					var relatedObj = {}

					relatedObj.id = populatedObj._id
					relatedObj.title = populatedObj.title
					relatedObj.author = populatedObj.author
					relatedObj.numPages = populatedObj.numPages
					relatedObj.purchaseDate = populatedObj.purchaseDate
					relatedObj.deleted = populatedObj.deleted

					related.push(relatedObj)
				}

				serviceItem.books = related;

				contentObject.categories.push(serviceItem)
			})
		}
		
		foundFunction(err)
	})
	
};
