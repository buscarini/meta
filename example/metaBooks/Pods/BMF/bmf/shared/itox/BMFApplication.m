//
//  BMFApplication.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFApplication.h"

@implementation BMFApplication

+ (BOOL) openURL:(NSURL *) url {
#if TARGET_OS_IPHONE
	return [[UIApplication sharedApplication] openURL:url];
#else
	return [[NSWorkspace sharedWorkspace] openURL:url];
#endif
	
}

@end
