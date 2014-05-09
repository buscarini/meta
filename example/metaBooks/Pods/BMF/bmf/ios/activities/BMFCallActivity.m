//
//  BMFCallActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCallActivity.h"

#import "BMF.h"
#import "BMFUtils.h"

@implementation BMFCallActivity

- (void) run:(BMFCompletionBlock)completionBlock {
	
	NSString *phone = [self finalPhoneValue];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]];
	BOOL result = [[UIApplication sharedApplication] openURL:url];

	NSError *error = nil;
	if (!result) error = [NSError errorWithDomain:@"Call activity" code:BMFErrorUnknown userInfo:@{
																								   NSLocalizedDescriptionKey : [NSString  stringWithFormat:BMFLocalized(@"Failed to open phone url: %@", nil),phone]
																									}];
	if (completionBlock) completionBlock(nil,error);
}

- (NSString *) finalPhoneValue {
	NSString *phone = self.value;
	if (!phone) phone = @"";

	phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
	phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
	phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
	
	return [BMFUtils escapeURLString:phone];
}

@end
