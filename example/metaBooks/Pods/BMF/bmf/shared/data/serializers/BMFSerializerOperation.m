//
//  BMFSerializerOperation.m
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFSerializerOperation.h"

@interface BMFSerializerOperation ()

@property (strong, nonatomic) id<BMFSerializerProtocol> serializer;

@end

@implementation BMFSerializerOperation {
	BOOL _isExecuting;
	BOOL _isFinished;
	BOOL _cancelled;
}


- (instancetype) initWithSerializer:(id<BMFSerializerProtocol>)serializer {
	BMFAssertReturnNil(serializer);
//	if (!serializer) {
//		[NSException raise:@"Serializer required" format:@""];
//		return nil;
//	}
	
    self = [super init];
    if (self) {
		self.serializer = serializer;
    }
    return self;
}

- (id)init {
	[NSException raise:@"serializer required. Use initWithWriter instead" format:@""];
    return nil;
}

- (BMFProgress *) progress {
	return self.serializer.progress;
}

- (void) performCancel {
	[self.serializer cancel];
}

- (void)performStart {
	for (NSOperation *op in self.dependencies) {
		if ([op isKindOfClass:[BMFOperation class]]) {
			BMFOperation *previous = (BMFOperation *)op;
			if ([previous.output isKindOfClass:[NSData class]]) {
				[self.serializer parse:previous.output completion:^(id result, NSError *error) {
					 self.output = result;
					[self finished];
				}];
			}
			else {
				if (!previous.output) {
					self.progress.failedError = [NSError errorWithDomain:@"No data returned from previous step" code:BMFErrorLacksRequiredData userInfo:nil];
					[self finished];
					return;
				}
				
				
				[self.serializer serialize:previous.output completion:^(id result, NSError *error) {
					self.output	= result;
					[self finished];
				}];
			}
		}
		else {
			DDLogWarn(@"Previous operation is not a BMFOperation: %@",op);
		}
	}
}

@end
