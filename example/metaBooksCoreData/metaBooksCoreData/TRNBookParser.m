#import "TRNBookParser.h"


#import "TRNBook.h"

@interface TRNBookParser()

@property (nonatomic, strong) NSDateFormatter *purchaseDateDateFormatter;

@end

@implementation TRNBookParser

- (instancetype)init
{
    self = [super init];
    if (self) {
		_purchaseDateDateFormatter = [[NSDateFormatter alloc] init];
		_purchaseDateDateFormatter.dateFormat = @"dd.MM.yyyy";
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


	
	return YES;
}

@end
