var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports.schema = mongoose.Schema({
	id: { type: Number },
	code: { type: String },
	deleted: { type: Boolean }
})
