var fs = require('fs');
var mongoose = require('mongoose');
var csv = require('csv');
var schema = require('./BookSchema')
var moment = require('moment');
var events = require('events');
var eventEmitter = new events.EventEmitter();

var compareEntities = function(a,b) {
	var result = 0;
	result = a.id-b.id;
	if (result!=0) return result;
	
	return result;	
};

module.exports.importFile = function(filePath,callback) {
	
	var Book = mongoose.model('Book', schema.schema)
	
	var imported = [];
	var numEntitiesImported = 0;
	
	csv()
	.from.path(filePath, { delimiter: ';', escape: '"' })
	.on('record', function(row,index) {
	
		var properties = {}
		if (row.length<7) {
			console.log("Error: number of columns not valid: " + row.length + " should be " + 7);
			return;
		}
		
		properties.id = parseInt(row[0],10)
		properties.title = row[1]
		properties.author = row[2]
		properties.numPages = parseInt(row[3],10)
		properties.purchaseDate = moment(row[4],"DD/MM/YYYY")
		properties.category = row[5]
		properties.cover = row[6]
		
		schema.schema.eachPath(function(key) {
			if (key instanceof Object) return;

			var options = schema.schema.path(key).options;				
			if ( ('default' in options) && !(key in properties) ) {
				var defaultValue = options['default'];
				
				if (typeof(defaultValue) != "function") {
					properties[key] = defaultValue;
				}
			}
		});
	
		Book.update({
			id : row[0]
		}, properties,{ upsert: true, multi: true },function(err) {
			if (err) {
				console.log("Error updating Book: " + err)
			}
			else {
				numEntitiesImported++;
				Book.findOne({ id : row[0]
										}).exec(function (err, entity) {
					imported.push(entity);
					eventEmitter.emit('entityImported');
				});
			}
		})
	})
	.on('end', function(count) {
		
		eventEmitter.on('entityImported',function() {
			numEntitiesImported--;
			if (numEntitiesImported!=0) return;
					
			imported.sort(compareEntities);
		
			var importedSorted = imported;
	
			Book.find().sort("id").exec(function(err,allEntities) {
				if (!err) {
								
					var importedIndex = 0;
					var dbIndex = 0;
					var numImported = importedSorted.length;
					var numInDB = allEntities.length;
								
					while (importedIndex<numImported && dbIndex<numInDB) {
						var importedEntity = importedSorted[importedIndex];
						var dbEntity = allEntities[dbIndex];
						
						importedId = importedEntity.id;
						dbId = dbEntity.id;
						
						var comparison = compareEntities(dbEntity,importedEntity);
//						dbId-importedId dbId<importedId
						if (comparison<0) {
							dbEntity.remove(function(err,entity) {
								if (err) {
									console.log("Error removing entity");
								}
							})
							dbIndex++;
						}
						else {
							if (comparison==0) {
								dbIndex++;
							}
							importedIndex++;
						}
					}
				
					while (dbIndex<numInDB) {
						var dbEntity = allEntities[dbIndex];
						dbEntity.remove(function(err,entity) {
							if (err) {
								console.log("Error removing entity");
							}
						});
						dbIndex++;
					}
				
					if (callback) {
						callback(err,importedSorted);
					}
				}
				else {
					console.log("Error finding all entitites: " + err)
				}
			});
			
		});
	})
	.on('error', function(error){
		console.log(error.message);
		if (callback) callback(error);
	});
	
}