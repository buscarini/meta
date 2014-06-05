var fs = require('fs');
var mongoose = require('mongoose');
var moment = require('moment');

var CategorySchema = require('./CategorySchema');
CategorySchema.schema.set('autoIndex', false);

var BookSchema = require('./BookSchema');
BookSchema.schema.set('autoIndex', false);

var CoverSchema = require('./CoverSchema');
CoverSchema.schema.set('autoIndex', false);


module.exports.findOneCategory = function(req, res,callback) {
	res.setHeader('Content-Type', 'application/json');

	var Category = mongoose.model('Category', CategorySchema.schema)
	var Book = mongoose.model('Book', BookSchema.schema)
	var Cover = mongoose.model('Cover', CoverSchema.schema)

	Category.find({
		_id : req._id
	})
	//.populate('books')
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

				var promise = Book.populate(unpopulated,{ path: "cover" });

				var relatedUnpopulated = unpopulated.books;
				var relatedPopulated = [];
				populated.books = relatedPopulated;

				var fillRelatedBook = function(relatedUnpopulated,relatedPopulated,parent) {

					// var promise = model.populate(parent,{ path: path });
					
					if (!(relatedUnpopulated instanceof Array)) {
						relatedUnpopulated = [relatedUnpopulated]
					}
					
					for (var index=0;index<relatedUnpopulated.length;index++) {
						var unpopulated = relatedUnpopulated[index];
						var populated = {}
						
						populated.id = unpopulated._id
						populated.title = unpopulated.title
						populated.author = unpopulated.author
						populated.numPages = unpopulated.numPages
						populated.purchaseDate = unpopulated.purchaseDate
						populated.deleted = unpopulated.deleted

						var promise = Cover.populate(unpopulated,{ path: "" });

						var relatedUnpopulated = unpopulated.cover;
						var relatedPopulated = [];
						populated.cover = relatedPopulated;

						var fillRelatedCover = function(relatedUnpopulated,relatedPopulated,parent) {

							// var promise = model.populate(parent,{ path: path });
							
							if (!(relatedUnpopulated instanceof Array)) {
								relatedUnpopulated = [relatedUnpopulated]
							}
							
							for (var index=0;index<relatedUnpopulated.length;index++) {
								var unpopulated = relatedUnpopulated[index];
								var populated = {}
								
								populated.id = unpopulated.id
								populated.imageUrl = unpopulated.url


								relatedPopulated.push(populated);
							}

							finished(null);
						};

						if (relatedUnpopulated.length==0) {
							Cover.find({ book: populated.id }).exec(function (err, items) {
								if (err) {
									res.send({"result": "1", "errorMessage":err.message});
								}
								else {
									relatedUnpopulated = items;
								}
								
								fillRelatedCover(relatedUnpopulated,relatedPopulated);
							});
						}
						else {
							fillRelatedCover(relatedUnpopulated,relatedPopulated);
						}

						relatedPopulated.push(populated);
					}

					finished(null);
				};

				if (relatedUnpopulated.length==0) {
					Book.find({ category: populated._id }).exec(function (err, items) {
						if (err) {
							res.send({"result": "1", "errorMessage":err.message});
						}
						else {
							relatedUnpopulated = items;
						}
						
						fillRelatedBook(relatedUnpopulated,relatedPopulated);
					});
				}
				else {
					fillRelatedBook(relatedUnpopulated,relatedPopulated);
				}
				content.categories.push(populated);
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
	var Book = mongoose.model('Book', BookSchema.schema)
	var Cover = mongoose.model('Cover', CoverSchema.schema)

	Category.find({
	})
	.sort({  id : 1  })
	// .populate('books')
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

				var promise = Book.populate(unpopulated,{ path: "cover" });

				var relatedUnpopulated = unpopulated.books;
				var relatedPopulated = [];
				populated.books = relatedPopulated;

				var fillRelatedBook = function(relatedUnpopulated,relatedPopulated,parent) {

					// var promise = model.populate(parent,{ path: path });
					
					if (!(relatedUnpopulated instanceof Array)) {
						relatedUnpopulated = [relatedUnpopulated]
					}
					
					for (var index=0;index<relatedUnpopulated.length;index++) {
						var unpopulated = relatedUnpopulated[index];
						var populated = {}
						
						populated.id = unpopulated._id
						populated.title = unpopulated.title
						populated.author = unpopulated.author
						populated.numPages = unpopulated.numPages
						populated.purchaseDate = unpopulated.purchaseDate
						populated.deleted = unpopulated.deleted

						var promise = Cover.populate(unpopulated,{ path: "" });

						var relatedUnpopulated = unpopulated.cover;
						var relatedPopulated = [];
						populated.cover = relatedPopulated;

						var fillRelatedCover = function(relatedUnpopulated,relatedPopulated,parent) {

							// var promise = model.populate(parent,{ path: path });
							
							if (!(relatedUnpopulated instanceof Array)) {
								relatedUnpopulated = [relatedUnpopulated]
							}
							
							for (var index=0;index<relatedUnpopulated.length;index++) {
								var unpopulated = relatedUnpopulated[index];
								var populated = {}
								
								populated.id = unpopulated.id
								populated.imageUrl = unpopulated.url


								relatedPopulated.push(populated);
							}

							finished(null);
						};

						if (relatedUnpopulated.length==0) {
							Cover.find({ book: populated.id }).exec(function (err, items) {
								if (err) {
									res.send({"result": "1", "errorMessage":err.message});
								}
								else {
									relatedUnpopulated = items;
								}
								
								fillRelatedCover(relatedUnpopulated,relatedPopulated);
							});
						}
						else {
							fillRelatedCover(relatedUnpopulated,relatedPopulated);
						}

						relatedPopulated.push(populated);
					}

					finished(null);
				};

				if (relatedUnpopulated.length==0) {
					Book.find({ category: populated._id }).exec(function (err, items) {
						if (err) {
							res.send({"result": "1", "errorMessage":err.message});
						}
						else {
							relatedUnpopulated = items;
						}
						
						fillRelatedBook(relatedUnpopulated,relatedPopulated);
					});
				}
				else {
					fillRelatedBook(relatedUnpopulated,relatedPopulated);
				}
				contentObject.categories.push(populated);
			})
		}
	})
	
};
