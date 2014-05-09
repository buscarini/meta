//
//  NSURL+BMF.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 12/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "NSURL+BMF.h"

#import "BMFUtils.h"

@implementation NSURL (BMF)

- (NSDictionary *) BMF_parametersDictionary {
	
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	
	NSScanner *scanner = [NSScanner scannerWithString:self.query];

	NSString *keyString;
	NSString *valueString;

	BOOL valueFound = YES;
	while (valueFound) {
		valueFound = [scanner scanUpToString:@"=" intoString:&keyString];
		[scanner scanString:@"=" intoString:nil];
		[scanner scanUpToString:@"&" intoString:&valueString];
		[scanner scanString:@"&" intoString:nil];
		
		NSString *finalValue = [valueString copy];
		if (!finalValue) finalValue = @"";
		
		if (keyString.length>0) {
			finalValue = [BMFUtils unescapeURLString:finalValue];
			dic[[keyString copy]] = finalValue;
		}
	}
	
	return dic;
}

@end
