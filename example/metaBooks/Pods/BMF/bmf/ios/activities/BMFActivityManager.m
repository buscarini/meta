//
//  BMFActivityManager.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivityManager.h"

#import "BMFMapActivity.h"
#import "BMFURLActivity.h"
#import "BMFCopyActivity.h"
#import "BMFEmailActivity.h"

#import "BMFCallActivity.h"
#import "BMFActionSheetActivity.h"
#import "BMFPresentViewControllerActivity.h"

@implementation BMFActivityManager

+ (NSString *) typeForItem:(id) item {
	if ([item isKindOfClass:[NSURL class]]) {
		return @"NSURL";
	}
	
	if ([item isKindOfClass:[NSString class]]) {
		return @"NSString";
	}
	
	if ([item isKindOfClass:[NSArray class]]) {
		return @"NSArray";
	}
	
	if ([item isKindOfClass:[UIViewController class]]) {
		return @"UIViewController";
	}
	
	return nil;
}

- (id<BMFActivityProtocol>) defaultActivityForItem:(id) item {
	NSString *className = [BMFActivityManager typeForItem:item];
	SEL dynamicSelector = NSSelectorFromString([NSString stringWithFormat:@"defaultActivityFor%@:", className]);
	if(![self respondsToSelector:dynamicSelector]) {
		DDLogWarn(@"Unsupported widget type %@", className);
		return nil;
	}
	
	BMFSuppressPerformSelectorLeakWarning(
									   [self performSelector:dynamicSelector withObject:item];
									   );

	return nil;
}

- (NSArray *) activitiesForItems:(NSArray *)items {
	
	NSMutableArray *result = [NSMutableArray array];
	
	for (id item in items) {
		NSArray *activities = [self activitiesForItem:item];
		[result addObjectsFromArray:activities];
	}
	
	return [NSArray arrayWithArray:result];
}

- (NSArray *) activitiesForItem:(id) item {
	NSString *className = [BMFActivityManager typeForItem:item];
	SEL dynamicSelector = NSSelectorFromString([NSString stringWithFormat:@"activitiesFor%@:", className]);
	if(![self respondsToSelector:dynamicSelector]) {
		DDLogWarn(@"Unsupported widget type %@", className);
		return nil;
	}
	
	BMFSuppressPerformSelectorLeakWarning(
									   [self performSelector:dynamicSelector withObject:item];
									   );
	
	return nil;
}

#pragma mark defaultActivity for class

- (id<BMFActivityProtocol>) defaultActivityForNSString:(NSString *) item {
	return [BMFCopyActivity new];
}


- (id<BMFActivityProtocol>) defaultActivityForNSArray:(NSArray *) item {
	if ([item.firstObject conformsToProtocol:@protocol(BMFActivityProtocol)]) {
		return [BMFActionSheetActivity new];
	}
	
	return nil;
}

- (id<BMFActivityProtocol>) defaultActivityForNSURL:(NSURL *) item {
	
	static NSDictionary *urlMappings = nil;
	if (!urlMappings) {
		urlMappings = @{
						@"mailto" : [BMFEmailActivity class],
						@"tel" : [BMFCallActivity class]
						};
	}
	
	id ActivityClass = urlMappings[item.scheme];
	if (!ActivityClass) {
		return [BMFURLActivity new];
	}
	
	return [ActivityClass new];
}

- (id<BMFActivityProtocol>) defaultActivityForUIViewController:(UIViewController *) item {
	return [BMFPresentViewControllerActivity new];
}

#pragma mark activities for class

- (NSArray *) activitiesForNSString:(NSString *) item {
	return @[ [BMFCopyActivity new], [BMFMapActivity new] ];
}


- (NSArray *) activitiesForNSArray:(NSArray *) item {
	if ([item.firstObject conformsToProtocol:@protocol(BMFActivityProtocol)]) {
		return @[ [BMFActionSheetActivity new] ];
	}
	
	return nil;
}

- (NSArray *) activitiesForNSURL:(NSURL *) item {
	
	static NSDictionary *urlMappings = nil;
	if (!urlMappings) {
		urlMappings = @{
						@"mailto" : [BMFEmailActivity class],
						@"tel" : [BMFCallActivity class]
						};
	}
	
	id ActivityClass = urlMappings[item.scheme];
	if (!ActivityClass) {
		return @[ [BMFURLActivity new] ];
	}
	
	return @[ [ActivityClass new] ];
}

- (NSArray *) activitiesForUIViewController:(UIViewController *) item {
	return @[ [BMFPresentViewControllerActivity new] ];
}

@end
