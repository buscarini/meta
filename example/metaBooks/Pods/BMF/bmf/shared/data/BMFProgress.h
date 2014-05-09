//
//  TNProgress.h
//  DataSources
//
//  Created by José Manuel Sánchez on 12/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@interface BMFProgress : NSObject

@property (nonatomic,assign) BOOL running;

@property (assign, nonatomic) int64_t estimatedTime; // This allows to compare progress units accross objects

@property (assign, nonatomic) int64_t totalUnitCount;
@property (assign, nonatomic) int64_t completedUnitCount;

@property (readonly, nonatomic) CGFloat fractionCompleted;

/// Provides information about the progress or the failure of the task
@property (atomic, copy) NSString *progressMessage;

/// If fractionCompleted is 1 and the operation was not successful, here you can find the error
@property (nonatomic, strong) NSError *failedError;

@property (nonatomic, readonly) BMFMutableWeakArray *children;

- (void) clear;

- (void) addChild:(BMFProgress *) child;

- (void) start;
- (void) stop: (NSError *) error;

@end
