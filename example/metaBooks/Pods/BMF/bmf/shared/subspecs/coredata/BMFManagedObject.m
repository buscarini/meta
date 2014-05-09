//
//  BMFManagedObject.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 30/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFManagedObject.h"

#import "BMFTaskManager.h"

//#import "BMFDefaultFactory.h"

#import "BMFNetworkFactoryProtocol.h"

#import "BMFTaskProtocol.h"
#import "BMFTaskManager.h"

#import "BMFBase.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation BMFManagedObject

@synthesize BMF_isDeleted;
@synthesize subscriptions;
@synthesize taskManager;

- (void) awakeFromFetch {
	[self performInit];
}

- (void) awakeFromInsert {
	[self performInit];
}

- (void) performInit {
	self.subscriptions = [NSMutableArray array];
	self.taskManager = [BMFTaskManager new];
}

- (void) prepareForDeletion {
	self.BMF_isDeleted = YES;
	
	[self.subscriptions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[obj dispose];
	}];
	
	self.subscriptions = nil;
	
	[self.taskManager cancelAll], self.taskManager = nil;
}

- (id<BMFTaskProtocol>) dataLoadTask:(NSString *)urlString {
	id<BMFNetworkFactoryProtocol> factory = [[BMFBase sharedInstance].factory BMF_castWithProtocol:@protocol(BMFNetworkFactoryProtocol)];
	return [factory dataLoadTask:urlString parameters:nil sender:self];
}

- (void) setupRemoteDataProperty:(NSString *) urlPropertyName dataPropertyName:(NSString *) dataPropertyName save:(BOOL)save {
	__weak BMFManagedObject *wself = self;
	
	void(^block)(id x) = ^(id x) {
			@try {
				[wself setValue:nil forKey:dataPropertyName];
			}
			@catch (NSException *exception) {
				DDLogError(@"Exception changing entity: %@",exception);
			}
			
			if (!x) return;
			
			id<BMFTaskProtocol> task = [self dataLoadTask:[self valueForKey:urlPropertyName]];
		
			[wself.taskManager addTask:task];
			[task start:^(id result, NSError *error) {
				if (error) {
					DDLogError(@"Error loading data: %@",error);
					return;
				}

				[wself.managedObjectContext performBlock:^{
					@try {
						[wself setValue:result forKey:dataPropertyName];
						if (save) {
							[wself.managedObjectContext MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
								if (error) {
									DDLogError(@"Error saving context: %@",error);
								}
							}];
						}
					}
					@catch (NSException *exception) {
						DDLogError(@"Exception changing entity: %@",exception);
					}
				}];
			}];
//		}];
	};
	
	RACSignal *signal = [[self rac_valuesForKeyPath:urlPropertyName observer:self] distinctUntilChanged];
	[[[signal take:1] filter:^BOOL(id value) {
		return ([wself valueForKey:dataPropertyName]==nil);
	}] subscribeNext:block];
	
	[self.subscriptions addObject:[[signal skip:1] subscribeNext:^(id value) {
		block(value);
	}]];
}

- (void) setupRemoteImageProperty:(NSString *) urlPropertyName dataPropertyName:(NSString *) dataPropertyName imagePropertyName:(NSString *) imagePropertyName save:(BOOL)save {
	
	__weak BMFManagedObject *wself = self;
	[self.subscriptions addObject:[[self rac_valuesForKeyPath:dataPropertyName observer:self] subscribeNext:^(id x) {
		@try {
			id data = [self valueForKey:dataPropertyName];
			if (data) [wself setValue:[BMFImage imageWithData:data] forKey:imagePropertyName];
			else [wself setValue:nil forKey:imagePropertyName];
		}
		@catch (NSException *exception) {
			DDLogError(@"Exception changing entity: %@",exception);
		}
	}]];
	
	[self setupRemoteDataProperty:urlPropertyName dataPropertyName:dataPropertyName save:save];
}

@end
