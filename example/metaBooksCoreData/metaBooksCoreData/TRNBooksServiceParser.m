
#import "TRNBooksServiceParser.h"

#import <BMF/BMF.h>
#import <BMF/BMFObjectParserProtocol.h>
#import <BMF/BMFParserStrategy.h>
#import <BMF/BMFCompareParserStrategy.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCategory.h"
#import "TRNCategoryParser.h"
#import "TRNBook.h"
#import "TRNCategory.h"
#import "TRNBookParser.h"
#import "TRNCategoryParser.h"

@interface TRNBooksServiceParser() <BMFObjectParserDelegateProtocol>
	
@property (nonatomic, strong) NSManagedObjectContext *localContext;
@property (nonatomic, strong) BMFParserStrategy *strategy;

@property (nonatomic, strong) TRNCategoryParser *TRNCategoryParserInstance;
@property (nonatomic, strong) TRNBookParser *TRNBookParserInstance;
@property (nonatomic, strong) TRNCategoryParser *TRNCategoryParserInstance;
	
@end
	
@implementation TRNBooksServiceParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _progress = [BMFProgress new];
		_progress.key = @"TRNBooksServiceParser";
    }
    return self;
}

#pragma mark BMFObjectParserDelegateProtocol

- (void) didParseObject:(id)object withDictionary:(NSDictionary *)dictionary {
	if ([object isKindOfClass:[TRNCategory class]]) {
		TRNCategory *entity = object;
	}
	else if ([object isKindOfClass:[TRNBook class]]) {
		TRNBook *entity = object;
		TRNCategoryParser *TRNCategoryParserInstance = [[TRNCategoryParser alloc] initWithContext:self.localContext];
		TRNCategoryParserInstance.delegate = self;
		
		entity.category = [self.strategy parseDictionaries:@[dictionary[@"category"]] localObjects:@[entity.category] objectParser:TRNCategoryParserInstance]].firstObject;
	}
	
	self.progress.completedUnitCount++;
}


- (void) calculateTotalUnitCount:(NSArray *) dictionaries {
	int64_t totalObjects = dictionaries.count;
	NSArray *items = nil;
	for (NSDictionary *dic in dictionaries) {
	}
	
	self.progress.totalUnitCount = totalObjects;
	int64_t totalObjects = dictionaries.count;
	NSArray *items = nil;
	for (NSDictionary *dic in dictionaries) {
		if (dic[@"category"]) totalObjects++;
	}
	
	self.progress.totalUnitCount = totalObjects;
}

- (void) parse:(NSDictionary *) rawObject completion:(BMFCompletionBlock) completionBlock {
	
	[self.progress start:@"TRNBooksServiceParser"];
		
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
		
			self.localContext = localContext;				
			self.strategy = [[BMFCompareParserStrategy alloc] init];
			self.strategy.batchSize = 100;


			self.TRNCategoryParserInstance = [[TRNCategoryParser alloc] initWithContext:localContext];
			self.TRNCategoryParserInstance.delegate = self;

			results = [self.strategy parseDictionaries:dictionaries localObjects:[self.TRNCategoryParserInstance fetchAllLocalObjectsSortedById] objectParser:self.TRNCategoryParserInstance];
		}
		
		
		dictionaries = rawObject[@"books"];
		if (dictionaries.count>0) {
		
			[self calculateTotalUnitCount:dictionaries];
		
			self.localContext = localContext;				
			self.strategy = [[BMFCompareParserStrategy alloc] init];
			self.strategy.batchSize = 100;


			self.TRNBookParserInstance = [[TRNBookParser alloc] initWithContext:localContext];
			self.TRNBookParserInstance.delegate = self;

			results = [self.strategy parseDictionaries:dictionaries localObjects:[self.TRNBookParserInstance fetchAllLocalObjectsSortedById] objectParser:self.TRNBookParserInstance];
		}
		
	}
	completion:^(BOOL success, NSError *error) {
		[self.progress stop:nil];

		if (completionBlock) completionBlock(results,nil);
	}];
}

- (void) cancel {
    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Parse Operation Cancelled",nil) }];
	[self.progress stop:error];
}

@end
