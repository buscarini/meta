var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports.schema = mongoose.Schema({
	_id: { type: Number },
	imageUrl: { type: String },
	book : { type: Number, ref: 'Book' }
})
