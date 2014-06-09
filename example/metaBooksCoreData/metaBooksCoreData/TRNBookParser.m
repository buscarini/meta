#import "TRNBookParser.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNBook.h"

@interface TRNBookParser()

@property (nonatomic, strong) NSDateFormatter *purchaseDateDateFormatter;

@end

@implementation TRNBookParser

- (instancetype) initWithContext:(NSManagedObjectContext *)context {
	self = [super initWithContext:context];
    if (self) {
		_purchaseDateDateFormatter = [[NSDateFormatter alloc] init];
		_purchaseDateDateFormatter.dateFormat = @"dd.MM.yyyy";
    }
    return self;
}

- (NSArray *) fetchAllLocalObjectsSortedById {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNBook"];
	
	fetchRequest.includesPropertyValues = NO;
	fetchRequest.sortDescriptors = @[
									[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES],
									 ];
	
	NSError *error = nil;
	NSArray *results = [self.context executeFetchRequest:fetchRequest error:&error];
	
	if (!results) {
		DDLogError(@"Error fetching local objects: %@",error);
	}
	
	return results;
}

- (NSComparisonResult) compareDictionary:(NSDictionary *) obj1 withDictionary:(NSDictionary *)obj2 {
	NSComparisonResult result;
	id id1 = obj1[@"id"];
	id id2 = obj2[@"id"];
	result = [id1 compare:id2];

	return result;
}

- (NSComparisonResult) compareObject:(TRNBook *)obj1 withDictionary:(NSDictionary *)obj2 {
	return [self compareDictionary:@{ 
			@"id" : [obj1 valueForKey:@"id"]
		} 
		withDictionary:obj2];
}

- (NSComparisonResult) compareObject:(TRNBook *)obj1 withObject:(TRNBook *)obj2 {
	NSComparisonResult result;

	id id1 = [obj1 valueForKey:@"id"];
	id id2 = [obj2 valueForKey:@"id"];
	result = [id1 compare:id2];
	
	return result;
}


- (BOOL) updateObject:(TRNBook *)object withDictionary:(NSDictionary *) dic error:(NSError **) error {
	id value;
	value = dic[@"id"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.id = [value integerValue];
	}
	else {
		// If required stop parsing
		*error = [NSError errorWithDomain:@"Parse" code:BMFErrorInvalidType userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Invalid type or missing key: %@ for property id",value] }];
		return NO;
	}

	value = dic[@"title"];
	if ([value isKindOfClass:[NSString class]]) {
		object.title = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property title: %@",value);
	}
	value = dic[@"author"];
	if ([value isKindOfClass:[NSString class]]) {
		object.author = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property author: %@",value);
	}
	value = dic[@"numPages"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.numPages = [value integerValue];
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property numPages: %@",value);
	}

	value = dic[@"purchaseDate"];
	if ([value isKindOfClass:[NSString class]]) {
		object.purchaseDate = [self.purchaseDateDateFormatter dateFromString:value];
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property purchaseDate: %@",value);
	}


	if ([self.delegate respondsToSelector:@selector(didParseObject:withDictionary:)]) [self.delegate didParseObject:object withDictionary:dic];
	return YES;
}

- (id) newObject {
	return [TRNBook MR_createInContext:self.context];
}

- (BOOL) deleteAllLocalObjects {
	return [TRNBook MR_truncateAllInContext:self.context];
}

@end
