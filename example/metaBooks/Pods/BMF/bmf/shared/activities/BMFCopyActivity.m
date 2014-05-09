//
//  BMFCopyActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCopyActivity.h"

#import "BMFPasteboard.h"

@implementation BMFCopyActivity

- (void) run:(BMFCompletionBlock)completionBlock {
	BMFAssertReturn(completionBlock);
	
	NSString *stringValue = [NSString BMF_cast:self.value];
	
	BOOL result = NO;
	if (stringValue.length>0) {
		result = [BMFPasteboard setString:stringValue];
	}
	
	NSError *error = nil;
	if (!result) error = [NSError errorWithDomain:@"CopyActivity" code:BMFErrorUnknown userInfo:nil];
	
	if (completionBlock) completionBlock(nil,error);
}

@end
