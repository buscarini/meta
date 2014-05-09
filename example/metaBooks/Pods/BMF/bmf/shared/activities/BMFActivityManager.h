//
//  BMFActivityManager.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFActivityProtocol.h"

@interface BMFActivityManager : NSObject

- (id<BMFActivityProtocol>) defaultActivityForItem:(id) item;
- (NSArray *) activitiesForItems:(NSArray *)items;

@end
