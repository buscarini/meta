
#import "TRNCategoriesServiceParser.h"

#import <BMF/BMF.h>
#import <BMF/BMFObjectParserProtocol.h>
#import <BMF/BMFParserStrategy.h>
#import <BMF/BMFCompareParserStrategy.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCategory.h"
#import "TRNBook.h"
#import "TRNCategoryParser.h"
#import "TRNBookParser.h"

@interface TRNCategoriesServiceParser() <BMFObjectParserDelegateProtocol>
	
@property (nonatomic, strong) NSManagedObjectContext *localContext;
@property (nonatomic, strong) BMFParserStrategy *strategy;

@property (nonatomic, strong) TRNCategoryParser *TRNCategoryParserInstance;
@property (nonatomic, strong) TRNBookParser *TRNBookParserInstance;
	
@end
	
@implementation TRNCategoriesServiceParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _progress = [BMFProgress new];
		_progress.key = @"TRNCategoriesServiceParser";
    }
    return self;
}

#pragma mark BMFObjectParserDelegateProtocol

- (void) didParseObject:(id)object withDictionary:(NSDictionary *)dictionary {
	if ([object isKindOfClass:[TRNCategory class]]) {
		TRNCategory *entity = object;
		TRNBookParser *TRNBookParserInstance = [[TRNBookParser alloc] initWithContext:self.localContext];
		TRNBookParserInstance.delegate = self;
		
		entity.books = [NSSet setWithArray:[self.strategy parseDictionaries:dictionary[@"books"] localObjects:entity.books.allObjects objectParser:TRNBookParserInstance]];
	}
	
	self.progress.completedUnitCount++;
}


- (void) calculateTotalUnitCount:(NSArray *) dictionaries {
	int64_t totalObjects = dictionaries.count;
	NSArray *items = nil;
	for (NSDictionary *dic in dictionaries) {
		items = dic[@"books"];
		totalObjects += items.count;
	}
	
	self.progress.totalUnitCount = totalObjects;
}

- (void) parse:(NSDictionary *) rawObject completion:(BMFCompletionBlock) completionBlock {
	
	[self.progress start:@"TRNCategoriesServiceParser"];
		
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
	__block NSArray *dictionaries = nil;

	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		
		dictionaries = rawObject[@"categories"];
		if (dictionaries.count>0) {
		
			[self calculateTotalUnitCount:dictionaries];
			
			[self.progress start:@"TRNCategoriesServiceParser"];
		
			self.localContext = localContext;				
			self.strategy = [[BMFCompareParserStrategy alloc] init];
			self.strategy.batchSize = 100;


			self.TRNCategoryParserInstance = [[TRNCategoryParser alloc] initWithContext:localContext];
			self.TRNCategoryParserInstance.delegate = self;

			results = [self.strategy parseDictionaries:dictionaries localObjects:[self.TRNCategoryParserInstance fetchAllLocalObjectsSortedById] objectParser:self.TRNCategoryParserInstance];
		}
		
	}
	completion:^(BOOL success, NSError *error) {
		[self.progress stop:error];

		if (completionBlock) completionBlock(results,nil);
	}];
}

- (void) cancel {
    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Parse Operation Cancelled",nil) }];
	[self.progress stop:error];
}

@end
