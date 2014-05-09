var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports.schema = mongoose.Schema({
	id: { type: Number },
	title: { type: String },
	author: { type: String },
	numPages: { type: Number },
	purchaseDate: { type: Date },
	deleted: { type: Boolean,default: false }
})
