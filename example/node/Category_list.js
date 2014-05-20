var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var schema = require('./CategorySchema');
schema.schema.set('autoIndex', false);

var booksSchema = require('./BookSchema');
booksSchema.schema.set('autoIndex', false);

module.exports.findOne = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', schema.schema)
	var Book = mongoose.model('Book', booksSchema.schema);

	Category.find({
		_id : req._id
	},function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			
			var contentObject = { "result" :"0" }
			contentObject.categories = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.books = item.books;

				contentObject.categories.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
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
			contentObject.categories = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.books = item.books;

				contentObject.categories.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	})
};
