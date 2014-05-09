//
//  BMFDataLoadFactory.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTaskProtocol.h"

@interface BMFDataLoadFactory : NSObject

- (id<BMFTaskProtocol>) dataLoadTask;

/// Template methods
- (NSURL *) url;

@end
