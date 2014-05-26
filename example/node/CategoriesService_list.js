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

				var populated = item.books;
				var related = [];

				var fillRelated = function(populated,related,serviceItem) {
					if (populated instanceof Array) {
						for (var index=0;index<populated.length;index++) {
							var populatedObj = populated[index];
							var relatedObj = {};
						
								relatedObj.id = populatedObj._id;
								relatedObj.title = populatedObj.title;
								relatedObj.author = populatedObj.author;
								relatedObj.numPages = populatedObj.numPages;
								relatedObj.purchaseDate = populatedObj.purchaseDate;
								relatedObj.deleted = populatedObj.deleted;

							related.push(relatedObj);
						}
					}
					else {
							related.id = populated._id;
							related.title = populated.title;
							related.author = populated.author;
							related.numPages = populated.numPages;
							related.purchaseDate = populated.purchaseDate;
							related.deleted = populated.deleted;
					}

					serviceItem.books = related;
					contentObject.categories.push(serviceItem);
					finished(null);
				};

				if (populated.length==0) {
					Book.find({ category: item._id }).exec(function (err, items) {
						if (err) {
							res.send({"result": "1", "errorMessage":err.message});
						}
						else {
							populated = items;
						}
						
						fillRelated(populated,related,serviceItem);
					});
				}
				else {
					fillRelated(populated,related,serviceItem);
				}


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
	var Book = mongoose.model('Book', booksSchema.schema);

	Category.find({
	})
	.sort({  id : 1  })
	.populate('books')
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

				var populated = item.books;
				var related = [];

				var fillRelated = function(populated,related,serviceItem) {
					if (populated instanceof Array) {
						for (var index=0;index<populated.length;index++) {
							var populatedObj = populated[index];
							var relatedObj = {};
						
								relatedObj.id = populatedObj._id;
								relatedObj.title = populatedObj.title;
								relatedObj.author = populatedObj.author;
								relatedObj.numPages = populatedObj.numPages;
								relatedObj.purchaseDate = populatedObj.purchaseDate;
								relatedObj.deleted = populatedObj.deleted;

							related.push(relatedObj);
						}
					}
					else {
							related.id = populated._id;
							related.title = populated.title;
							related.author = populated.author;
							related.numPages = populated.numPages;
							related.purchaseDate = populated.purchaseDate;
							related.deleted = populated.deleted;
					}

					serviceItem.books = related;
					contentObject.categories.push(serviceItem);
					finished(null);
				};

				if (populated.length==0) {
					Book.find({ category: item._id }).exec(function (err, items) {
						if (err) {
							res.send({"result": "1", "errorMessage":err.message});
						}
						else {
							populated = items;
						}
						
						fillRelated(populated,related,serviceItem);
					});
				}
				else {
					fillRelated(populated,related,serviceItem);
				}


			})
		}
	})
	
};
