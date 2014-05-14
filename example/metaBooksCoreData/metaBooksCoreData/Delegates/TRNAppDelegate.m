//
//  TRNAppDelegate.m
//  metaBooksCoreData
//
//  Created by José Manuel Sánchez on 5/14/14
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNAppDelegate.h"

#import <BMF/BMFDefaultConfiguration.h>

@implementation TRNAppDelegate

- (BOOL) application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	BMFDefaultConfiguration *config = [BMFDefaultConfiguration new];
	config.useCoreData = YES;
	[[BMFBase sharedInstance] loadConfig:config];
	
	return YES;
}

@end
