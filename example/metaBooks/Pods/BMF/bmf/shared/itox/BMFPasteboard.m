//
//  BMFPasteboard.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFPasteboard.h"

#import "BMFTypes.h"

@implementation BMFPasteboard


+ (BOOL) setString:(NSString *) string {
	BMFIXPasteboard *pasteboard = [BMFIXPasteboard generalPasteboard];
	
#if TARGET_OS_IPHONE
    [pasteboard setString:string];
	return YES;
#else
	[pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
	return [pasteboard setString:string forType:NSStringPboardType];
#endif
	

}

+ (NSString *) string {
	BMFIXPasteboard *pasteboard = [BMFIXPasteboard generalPasteboard];
	
#if TARGET_OS_IPHONE
	return [pasteboard string];
#else
	return [pasteboard stringForType:NSStringPboardType];
#endif

}

@end
