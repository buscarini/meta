var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports.schema = mongoose.Schema({
	_id: { type: Number },
	title: { type: String },
	author: { type: String },
	numPages: { type: Number },
	purchaseDate: { type: Date },
	deleted: { type: Boolean,default: false },
	category : { type: Number, ref: 'Category' },
	cover : { type: Number, ref: 'Cover' }
})
