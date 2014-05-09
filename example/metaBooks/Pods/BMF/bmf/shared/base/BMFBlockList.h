//
//  VITWBlockList.h
//  Yellow iPhone
//
//  Created by José Manuel Sánchez on 28/08/13.
//  Copyright (c) 2013 Vitaminew. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMF.h"

@interface BMFBlockList : NSObject

- (NSUInteger) add: (BMFCompletionBlock) block;
- (void) remove: (BMFCompletionBlock) block;
- (void) removeBlockAt:(NSUInteger) index;

- (void) run:(id) result error:(NSError *) error;

@end
