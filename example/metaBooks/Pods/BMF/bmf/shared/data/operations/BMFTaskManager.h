//
//  BMFTaskManager.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 12/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTaskProtocol.h"

// Tracks operations and allows to cancel them all
@interface BMFTaskManager : NSObject

- (void) addTask: (id<BMFTaskProtocol>) task;

- (NSInteger) count;
- (BOOL) allFinished;
- (void) cancelAll;


@end
