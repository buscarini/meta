#import "TRNCoverParser.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCover.h"

@interface TRNCoverParser()


@end

@implementation TRNCoverParser

- (instancetype) initWithContext:(NSManagedObjectContext *)context {
	self = [super initWithContext:context];
    if (self) {
    }
    return self;
}

- (NSArray *) fetchAllLocalObjectsSortedById {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNCover"];
	
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

- (NSComparisonResult) compareObject:(TRNCover *)obj1 withDictionary:(NSDictionary *)obj2 {
	return [self compareDictionary:@{ 
			@"id" : [obj1 valueForKey:@"id"]
		} 
		withDictionary:obj2];
}

- (NSComparisonResult) compareObject:(TRNCover *)obj1 withObject:(TRNCover *)obj2 {
	NSComparisonResult result;

	id id1 = [obj1 valueForKey:@"id"];
	id id2 = [obj2 valueForKey:@"id"];
	result = [id1 compare:id2];
	
	return result;
}


- (BOOL) updateObject:(TRNCover *)object withDictionary:(NSDictionary *) dic error:(NSError **) error {
	id value;
	value = dic[@"id"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.id = [value integerValue];
	}
	else {
		// If required stop parsing
		*error = [NSError errorWithDomain:@"Parse" code:BMFErrorInvalidType userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Invalid type or missing key: %@ for property id when parsing object: %@",value,self] }];
		return NO;
	}

	value = dic[@"imageUrl"];
	if ([value isKindOfClass:[NSString class]]) {
		object.imageUrl = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property imageUrl: %@",value);
	}
	if ([self.delegate respondsToSelector:@selector(didParseObject:withDictionary:)]) [self.delegate didParseObject:object withDictionary:dic];
	return YES;
}

- (id) newObject {
	return [TRNCover MR_createInContext:self.context];
}

- (BOOL) deleteAllLocalObjects {
	return [TRNCover MR_truncateAllInContext:self.context];
}

@end
