//
//  TNStringLoader.m
//  DataSources
//
//  Created by José Manuel Sánchez on 23/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFStringLoader.h"

#import "BMF.h"

@implementation BMFStringLoader

@synthesize progress = _progress;

- (instancetype) init {
    self = [super init];
    if (self) {
		_progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (void) cancel {
}

- (void) load:(BMFCompletionBlock) completionBlock {
	
	BMFAssertReturn(_string);
	BMFAssertReturn(completionBlock);
	
//	if (!_string) {
//		[NSException raise:BMFLocalized(@"Error loading. File Url can't be nil",nil) format:@"%@",self];
//		return;
//	}
	
	[self.progress start];
	
	NSError *error = nil;
	
	id object = [_string dataUsingEncoding:NSUTF8StringEncoding];
	
	[self.progress stop:error];
	
	if (completionBlock) completionBlock(object,error);
}

@end
