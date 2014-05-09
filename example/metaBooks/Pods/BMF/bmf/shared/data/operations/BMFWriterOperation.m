//
//  TNWriterOperation.m
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFWriterOperation.h"

@interface BMFWriterOperation()

@property (strong, nonatomic) id<BMFWriterProtocol> writer;

@end

@implementation BMFWriterOperation

- (instancetype) initWithWriter:(id<BMFWriterProtocol>) writer {
	BMFAssertReturnNil(writer);
	
//	if (!writer) {
//		[NSException raise:@"Writer required" format:@""];
//		return nil;
//	}
	
    self = [super init];
    if (self) {
		self.writer = writer;
    }
    return self;
}

- (id)init {
	[NSException raise:@"writer required. Use initWithWriter instead" format:@""];
    return nil;
}

- (BMFProgress *) progress {
	return self.writer.progress;
}

- (void) performCancel {
	[self.writer cancel];
}

- (void)performStart {

	for (NSOperation *op in self.dependencies) {
		if ([op isKindOfClass:[BMFOperation class]]) {
			BMFOperation *previous = (BMFOperation *)op;
			if ([previous.output isKindOfClass:[NSData class]]) {
				[self.writer write:previous.output completion:^(id result,NSError *error) {
					if (error) {
						DDLogError(@"Write operation failed: %@",error);
					}
					[self finished];
				}];
			}
			else {
				DDLogWarn(@"Previous operation is not a BMFOperation: %@",op);
			}
		}
	}
}

@end
