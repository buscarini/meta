//
//  BMFMapActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFMapActivity.h"

#import "BMF.h"
#import "BMFUtils.h"

@implementation BMFMapActivity


- (void) run:(BMFCompletionBlock)completionBlock {
	NSString *address = self.value;
	if (!address) address = @"";
	
	address = [BMFUtils escapeURLString:address];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@",address]];
	BOOL result = [BMFApplication openURL:url];
	
	NSError *error = nil;
	if (!result) error = [NSError errorWithDomain:@"Map activity" code:BMFErrorUnknown userInfo:@{
																								   NSLocalizedDescriptionKey : [NSString  stringWithFormat:BMFLocalized(@"Failed to open address: %@", nil),address]
																								   }];
	if (completionBlock) completionBlock(nil,error);
}

@end
