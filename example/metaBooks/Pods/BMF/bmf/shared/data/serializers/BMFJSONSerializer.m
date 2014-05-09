//
//  BMFJSONSerializer.m
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFJSONSerializer.h"

#import "BMF.h"

@implementation BMFJSONSerializer

- (id)init
{
    self = [super init];
    if (self) {
        self.readingOptions = NSJSONReadingMutableContainers;
		self.writingOptions = 0;
		_progress = [BMFProgress new];
    }
    return self;
}


- (void) cancel {
	
}

- (void) parse:(NSData *)data completion:(BMFCompletionBlock)completionBlock {
	BMFAssertReturn(data);
	BMFAssertReturn(completionBlock);
//	if (!data || !completionBlock) {
//		[NSException raise:BMFLocalized(@"Data and completion block are mandatory for parsing and one of those is nil", nil) format:@""];
//		return;
//	}

	[self.progress start];
	
	@try {
		NSError *error = nil;
		id object = [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:&error];

		[self.progress stop:error];
		
		completionBlock(object,error);
	}
	@catch (NSException *exception) {
		NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorUnknown userInfo:@{ NSLocalizedDescriptionKey: [exception reason] }];
		[self.progress stop:error];
		completionBlock(nil,error);
	}
}

- (void) serialize:(id) object completion:(BMFCompletionBlock)completionBlock {
	BMFAssertReturn(object);
	BMFAssertReturn(completionBlock);
//	if (!object || !completionBlock) {
//		[NSException raise:BMFLocalized(@"Object and completion block are mandatory for parsing and one of those is nil", nil) format:@""];
//		return;
//	}
	
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:object options:self.writingOptions error:&error];
	completionBlock(data,error);
}

@end
