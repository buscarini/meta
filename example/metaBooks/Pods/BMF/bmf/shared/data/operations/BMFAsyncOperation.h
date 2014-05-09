//
//  BMFAsyncOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFOperation.h"

@interface BMFAsyncOperation : BMFOperation

@property (nonatomic, assign) BOOL cancelled;

/// You should call this method when done
- (void)finished;

/// Template methods – override these
- (void) performStart;
- (void) performCancel;

@end
