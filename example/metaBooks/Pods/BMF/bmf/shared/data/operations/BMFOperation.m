//
//  TNOperation.m
//  DataSources
//
//  Created by José Manuel Sánchez on 12/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFOperation.h"

@implementation BMFOperation

- (id)init
{
    self = [super init];
    if (self) {
        self.progress = [[BMFProgress alloc] init];
		self.progress.estimatedTime = 0.01;
    }
    return self;
}

- (void) clear {
	self.output = nil;
	[self.progress clear];
}

- (void)dealloc {
//	DDLogInfo(@"Dealloc bmfoperation: %@",self);
    [self clear];
}


@end
