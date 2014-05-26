#import "TRNCategoryParser.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>


#import "TRNCategory.h"

@interface TRNCategoryParser()


@end

@implementation TRNCategoryParser

- (instancetype) initWithContext:(NSManagedObjectContext *)context {
	self = [super initWithContext:context];
    if (self) {
    }
    return self;
}

- (NSArray *) fetchAllLocalObjectsSortedById {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNCategory"];
	
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

- (NSComparisonResult) compareObject:(TRNCategory *)obj1 withDictionary:(NSDictionary *)obj2 {
	return [self compareDictionary:@{ 
			@"id" : [obj1 valueForKey:@"id"]
		} 
		withDictionary:obj2];
}

- (NSComparisonResult) compareObject:(TRNCategory *)obj1 withObject:(TRNCategory *)obj2 {
	NSComparisonResult result;

	id id1 = [obj1 valueForKey:@"id"];
	id id2 = [obj2 valueForKey:@"id"];
	result = [id1 compare:id2];
	
	return result;
}


- (BOOL) updateObject:(TRNCategory *)object withDictionary:(NSDictionary *) dic error:(NSError **) error {
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

	if ([self.delegate respondsToSelector:@selector(didParseObject:withDictionary:)]) [self.delegate didParseObject:object withDictionary:dic];
	return YES;
}

- (id) newObject {
	return [TRNCategory MR_createInContext:self.context];
}

- (BOOL) deleteAllLocalObjects {
	return [TRNCategory MR_truncateAllInContext:self.context];
}


@end
