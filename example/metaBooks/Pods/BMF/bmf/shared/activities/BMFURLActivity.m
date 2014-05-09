//
//  BMFURLActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFURLActivity.h"

#import "BMF.h"

@implementation BMFURLActivity

- (NSURL *) url {
	
	NSURL *result = [NSURL BMF_cast:self.value];
	if (result) return result;
	
	NSString *stringResult = [NSString BMF_cast:self.value];
	if (stringResult) return [NSURL URLWithString:stringResult];
	
	return nil;
}

- (void) run:(BMFCompletionBlock)completionBlock {

	NSURL *url = [self url];
	
	BOOL result = [BMFApplication openURL:url];
//	BOOL result = [[UIApplication sharedApplication] openURL:url];
	
	NSError *error = nil;
	if (!result) {
		error = [NSError errorWithDomain:@"URL activity" code:BMFErrorUnknown userInfo:@{
																						 NSLocalizedDescriptionKey : [NSString  stringWithFormat:BMFLocalized(@"Failed to open url: %@", nil),url]
																						 }];
		
	}
	
	if (completionBlock) completionBlock(nil,error);
}

@end
