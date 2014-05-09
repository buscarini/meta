//
//  NSData+BMF.m
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import "NSData+BMF.h"

#import <Base64/MF_Base64Additions.h>

@implementation NSData (BMF)

- (NSData *) BMF_base64EncodedData {
	if ([self respondsToSelector:@selector(base64EncodedDataWithOptions:)]) {
		return [self base64EncodedDataWithOptions:0];
	}
	else {
		NSString *string = [self base64String];
		return [string dataUsingEncoding:NSUTF8StringEncoding];
	}
}

- (NSData *) BMF_base64DecodedData {
	
	id dataClass = [self class];
	if ([dataClass respondsToSelector:@selector(initWithBase64EncodedData:options:)]) {
		return [[NSData alloc] initWithBase64EncodedData:self options:0];
	}
	else {
		NSString *encodedString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
		return [NSData dataWithBase64String:encodedString];
	}
}


@end
