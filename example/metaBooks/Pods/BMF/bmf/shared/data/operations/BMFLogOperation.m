//
//  BMFLogOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFLogOperation.h"

#import "BMFTypes.h"

@implementation BMFLogOperation

- (void)main {
	self.progress.completedUnitCount = 0;
	for (NSOperation *op in self.dependencies) {
		if ([op isKindOfClass:[BMFOperation class]]) {
			BMFOperation *previous = (BMFOperation *)op;
			
			if (previous.output) {
				DDLogDebug(@"Previous operation: %@ output: %@",previous,previous.output);
				self.output = previous.output;
			}
		}
	}
	
	self.progress.completedUnitCount = 1;
}

@end
