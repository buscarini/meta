
#import "TRNParser.h"

#import <BMF/BMF.h>

#import "TRNBook.h"
	
@implementation TRNParser

- (void) parse:(NSDictionary *) rawObject completion:(BMFCompletionBlock) completionBlock {
	
	[self.progress start];
	
	@try {
		
		/// Check result
		id result = rawObject[@"result"];
		if (![result isEqual:@"0"]) {
			NSString *errorMessage = rawObject[@"errorMessage"];
			if (!errorMessage) {
				errorMessage = BMFLocalized(@"Unknown error",nil);
			}
		    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorData userInfo:@{ NSLocalizedDescriptionKey : errorMessage }];
			[self.progress stop:error];
			if (completionBlock) completionBlock(nil,error);
			return;
		}
	
		NSMutableArray *results = nil;
	
		results = [NSMutableArray array];
		
		NSArray *dictionaries = rawObject[@"books"];
		for (NSDictionary *dic in dictionaries) {
			TRNBook *object = [TRNBook new];

			id value = nil;
			NSArray *values = nil;

			value = dic[@"id"];
			if ([value isKindOfClass:[NSNumber class]]) {
				object.id = [value integerValue];
			}
			else {
				// If required stop parsing
				if (completionBlock) completionBlock(nil,[NSError errorWithDomain:@"Parse" code:BMFErrorInvalidType userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Invalid type or missing key: %@ for property id",value] }]);
				return;
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
				NSDateFormatter *dateFormatter = [NSDateFormatter new];
				dateFormatter.dateFormat = @"dd.MM.yyyy";
				object.purchaseDate = [dateFormatter dateFromString:value];
			}
			else {
				DDLogWarn(@"Invalid type or missing key for property purchaseDate: %@",value);
			}


			[results addObject:object];
		}

		[self.progress stop:nil];

		if (completionBlock) completionBlock(results,nil);
	}
	@catch (NSException *exception) {
		DDLogError(@"Exception in parse: %@",exception);
	}
}

- (void) cancel {
    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Parse Operation Cancelled",nil) }];
	[self.progress stop:error];
}

@end
