var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var BookPopulation = require('./BookPopulation');

var CategoryPopulation = require('./CategoryPopulation')

module.exports.findOneCategory = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', CategorySchema.schema)
	var Book = mongoose.model('Book', BookSchema.schema)

	Category.find({
		id : req.id
	})
	//.populate('books')
	.exec(function (err, items) {
		// if (err) {
// 			res.send({"result": "1", "errorMessage":err.message});
// 		}
// 		else {
// 			contentObject = { "result" :"0" };
// 			contentObject.categories = new Array();
// 			
// 			var sendResponse = function(err) {
// 				res.send(contentObject);
// 					
// 				if (callback) callback();
// 			};
// 			
// 			var numOps = items.length;
// 			var finished = function(error) {
// 				numOps--;
// 				if (numOps==0) {
// 					sendResponse(err);
// 				}
// 			};
// 			
// 			
// 			items.forEach(function(unpopulated) {
// 				var populated = {}
// 				populated.id = unpopulated.id
populated.title = unpopulated.title

var promise = Category.populate(unpopulated,{ path: "books" });


var relatedUnpopulated = unpopulated.books;
var relatedPopulated = [];

var fillRelatedBook = function(relatedUnpopulated,relatedPopulated,parent) {

	// var promise = model.populate(parent,{ path: path });
	
	if (!(relatedUnpopulated instanceof Array)) {
		relatedUnpopulated = [relatedUnpopulated]
	}
	
	for (var index=0;index<relatedUnpopulated.length;index++) {
		var unpopulated = relatedUnpopulated[index];
		var populated = {}
		
		populated.id = unpopulated.id
		populated.title = unpopulated.title
		populated.author = unpopulated.author
		populated.numPages = unpopulated.numPages
		populated.purchaseDate = moment(unpopulated.purchaseDate).format("DD.MM.YYYY")
		populated.deleted = unpopulated.deleted

		var promise = Book.populate(unpopulated,{ path: "cover" });

		var fillRelatedCover = function(relatedUnpopulated,relatedPopulated,parent) {
			var relatedUnpopulated = unpopulated.cover;
			var relatedPopulated = {};
			populated.id = unpopulated.id
			populated.imageUrl = unpopulated.imageUrl

			var promise = Cover.populate(unpopulated,{ path: "" });

			
			parent.cover = relatedPopulated;
			
			finished(null);	
		}

		fillRelatedCover(relatedUnpopulated,relatedPopulated,populated);


		relatedPopulated.push(populated);
	}

	parent.books = relatedPopulated;

	finished(null);
};

if (relatedUnpopulated.length==0) {
	Book.find({ category: populated.id }).exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			relatedUnpopulated = items;
		}
		
		fillRelatedBook(relatedUnpopulated,relatedPopulated,populated);
	});
}
else {
	fillRelatedBook(relatedUnpopulated,relatedPopulated,populated);
}

// 				content.categories.push(populated);
// 				//
// 			})
// 			
// 		}
		
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			CategoryPopulation.populate(items,function(populated) {

				contentObject.result = "0";

				contentObject.categories = populated;
				
				res.send(contentObject);
				if (callback) callback()
			});
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
	var Book = mongoose.model('Book', BookSchema.schema)

	Category.find({
	})
	.sort({  id : -1  })
	.exec(function (err, items) {
		if (err) {
			res.send({"result": "1", "errorMessage":err.message});
		}
		else {
			CategoryPopulation.populate(items,function(populated) {

				contentObject.result = "0";

				contentObject.categories = populated;
				
				res.send(contentObject);
				if (callback) callback()
			});
		}		
	})
	
};
