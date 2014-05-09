//
//  TNFileWriter.m
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFFileWriter.h"

@implementation BMFFileWriter

@synthesize progress = _progress;


- (instancetype) init {
    self = [super init];
    if (self) {
		_options = NSDataWritingAtomic;
		_progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (void) cancel {
}

- (void) write:(NSData *)data completion:(BMFCompletionBlock) completionBlock {
	BMFAssertReturn(data);
	
//	if (!data) {
//		[NSException raise:@"No data to write" format:nil];
//		return;
//	}
	
	[self.progress start];
	
	NSError *error = nil;
	[data writeToURL:_fileUrl options:self.options error:&error];

	[self.progress stop:error];
	
	if (completionBlock) completionBlock(nil,error);
}

@end
