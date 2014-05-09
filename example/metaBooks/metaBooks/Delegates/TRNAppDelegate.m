//
//  TRNAppDelegate.m
//  metaBooks
//
//  Created by José Manuel Sánchez on 5/8/14
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNAppDelegate.h"

#import <BMF/BMFDefaultConfiguration.h>
#import <BMF/BMF.h>

@implementation TRNAppDelegate

- (BOOL) application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	BMFDefaultConfiguration *config = [BMFDefaultConfiguration new];
	[[BMFBase sharedInstance] loadConfig:config];
	
	return YES;
}

@end
