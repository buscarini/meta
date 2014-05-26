
#import "TRNCategoriesServiceParser.h"

#import <BMF/BMF.h>
#import <BMF/BMFObjectParserProtocol.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCategory.h"
#import "TRNBook.h"
#import "TRNCategoryParser.h"
#import "TRNBookParser.h"

#import "BMFCompareParserStrategy.h"

#import <BMF/BMFObjectParserProtocol.h>

@interface TRNCategoriesServiceParser() <BMFObjectParserDelegateProtocol>

@property (nonatomic, strong) NSManagedObjectContext *localContext;
@property (nonatomic, strong) TRNCategoryParser *categoryParser;
@property (nonatomic, strong) TRNBookParser *bookParser;

@end

@implementation TRNCategoriesServiceParser

#pragma mark BMFObjectParserDelegateProtocol

- (void) didParseObject:(id)object withDictionary:(NSDictionary *)dictionary {
	if ([object isKindOfClass:[TRNCategory class]]) {
		TRNCategory *entity = object;
		TRNBookParser *bookParser = [[TRNBookParser alloc] initWithContext:self.localContext];
		BMFParserStrategy *strategy = [[BMFCompareParserStrategy alloc] init];
		
		entity.books = [NSSet setWithArray:[strategy parseDictionaries:dictionary[@"books"] localObjects:entity.books.allObjects objectParser:bookParser]];
	}
}

#pragma mark BMFParserProtocol

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
	
		__block NSArray *results = nil;
		NSArray *dictionaries = nil;
		
		dictionaries = rawObject[@"categories"];
		if (dictionaries.count>0) {
			
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				
				self.localContext = localContext;
				
				self.categoryParser = [[TRNCategoryParser alloc] initWithContext:localContext];
				self.categoryParser.delegate = self;
				self.bookParser = [[TRNBookParser alloc] initWithContext:localContext];
				self.bookParser.delegate = self;
				
				BMFParserStrategy *strategy = [[BMFCompareParserStrategy alloc] init];

				results = [strategy parseDictionaries:dictionaries localObjects:[self.categoryParser fetchAllLocalObjectsSortedById] objectParser:self.categoryParser];

			
			} completion:^(BOOL success, NSError *error) {
				[self.progress stop:nil];

				if (completionBlock) completionBlock(results,nil);
			}];
		
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
