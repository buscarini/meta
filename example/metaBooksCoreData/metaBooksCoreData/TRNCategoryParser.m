#import "TRNCategoryParser.h"


#import "TRNCategory.h"

@interface TRNCategoryParser()


@end

@implementation TRNCategoryParser

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSComparisonResult) compareDictionary:(NSDictionary *) obj1 withDictionary:(NSDictionary *)obj2 {
	NSComparisonResult result;
	id id1 = obj1[@"id"];
	id id2 = obj2[@"id"];
	result = [id1 compare:id2];
	if (result!=NSOrderedSame) return result;

	return NSOrderedSame;
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

	
	return YES;
}

@end
