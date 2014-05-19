var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var schema = require('./CategorySchema')

module.exports.findOne = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', schema.schema)

	Category.find({
		id : req.id
	},function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.errmsg});
		}
		else {
			
			var contentObject = { "result" :"0" }
			contentObject.categories = new Array()
			items.forEach(function(item) {
				var serviceItem = {}
				
				serviceItem.id = item.id
				serviceItem.title = item.title
				
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
				
				serviceItem.id = item.id
				serviceItem.title = item.title
				serviceItem.books = item.books;
				
				contentObject.categories.push(serviceItem)
			})
			
			res.send(contentObject)
					
			if (callback) callback()
		}
	})
};
