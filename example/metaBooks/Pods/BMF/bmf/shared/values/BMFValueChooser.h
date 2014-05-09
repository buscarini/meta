//
//  BMFValueChooser.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValueProtocol.h"
#import "BMFActionableProtocol.h"

@interface BMFValueChooser : NSObject <BMFActionableProtocol>

@property (nonatomic, weak) id<BMFValueProtocol> value;

/// Choose value for the next invocation of action:completion:
- (void) nextValue;

/// Read current value
- (void) action:(id) input completion:(BMFCompletionBlock) completion;

- (void) valueAction:(id) input completion:(BMFCompletionBlock) completion;
- (void) arrayAction:(NSArray *) input completion:(BMFCompletionBlock) completion;
- (void) dicAction:(NSDictionary *) input completion:(BMFCompletionBlock) completion;

@end
