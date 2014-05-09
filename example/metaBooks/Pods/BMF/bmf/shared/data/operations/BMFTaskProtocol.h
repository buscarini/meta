//
//  BMFTaskProtocol.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

/*
 
 A task can be composed of multiple operations. It may be a data load task that loads data from a url, serializes it, parses it and stores it. It allows to check progress and retry if it fails.
 
 */

#import <Foundation/Foundation.h>

#import "BMFProgress.h"
#import "BMFTypes.h"

@protocol BMFTaskProtocol <NSObject>

@property (nonatomic, strong) BMFProgress *progress;

- (BOOL) start: (BMFCompletionBlock) completion;
- (BOOL) retry;
- (void) cancel;

@end
