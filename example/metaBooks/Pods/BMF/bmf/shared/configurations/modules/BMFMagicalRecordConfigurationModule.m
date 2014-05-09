//
//  BMFMagicalRecordConfigurationModule.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFMagicalRecordConfigurationModule.h"

#import "BMFTypes.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFMagicalRecordConfigurationModule

- (BOOL) setup {
	
	[MagicalRecord setupAutoMigratingCoreDataStack];
	
	
	if (self.automaticSaving) {
		NSMutableArray *notificationSignals = [NSMutableArray array];
		
#if TARGET_OS_IPHONE
		RACSignal *backgroundSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil];
		[notificationSignals addObject:backgroundSignal];
#endif
		RACSignal *terminateSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFApplicationWillTerminateNotification object:nil];
		[notificationSignals addObject:terminateSignal];
		
		[[[RACSignal merge:notificationSignals] deliverOn:[RACScheduler mainThreadScheduler] ] subscribeNext:^(id x) {
			[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
		}];
	}
		
	return YES;
}

- (void) tearDown {
	[MagicalRecord cleanUp];
}

@end
