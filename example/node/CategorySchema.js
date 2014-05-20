var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports.schema = mongoose.Schema({
	_id: { type: Number },
	title: { type: String },
	books : [{ type: Number, ref: 'Book' }]
})
