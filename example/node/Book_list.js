var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var schema = require('./BookSchema');
schema.schema.set('autoIndex', false);

var categorySchema = require('./CategorySchema');
categorySchema.schema.set('autoIndex', false);

module.exports.findOne = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Book = mongoose.model('Book', schema.schema)
	var Category = mongoose.model('Category', categorySchema.schema);

	Book.find({
		_id : req._id,
		deleted : { $eq: false }
	},function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			
			var contentObject = { "result" :"0" }
			contentObject.books = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.author = item.author
				serviceItem.numPages = item.numPages
				serviceItem.purchaseDate = moment(item.purchaseDate).format("DD.MM.YYYY")
				serviceItem.deleted = item.deleted
				serviceItem.category = item.category;

				contentObject.books.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	})
};

module.exports.findAll = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Book = mongoose.model('Book', schema.schema)
	var Category = mongoose.model('Category', categorySchema.schema);

	Book.find({
		deleted : { $eq: false }
	})
	.sort({  id : 1  })
	.populate('category')
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.errmsg});
		}
		else {
			
			var contentObject = { "result" :"0" }
			contentObject.books = new Array()
			items.forEach(function(item) {
				var serviceItem = {}

				serviceItem.id = item._id
				serviceItem.title = item.title
				serviceItem.author = item.author
				serviceItem.numPages = item.numPages
				serviceItem.purchaseDate = moment(item.purchaseDate).format("DD.MM.YYYY")
				serviceItem.deleted = item.deleted
				serviceItem.category = item.category;

				contentObject.books.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	})
};
