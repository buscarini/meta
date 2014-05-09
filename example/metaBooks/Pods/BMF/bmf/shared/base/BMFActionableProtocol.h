//
//  BMFActionable.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFActionableProtocol <NSObject>

- (void) action:(id) input completion:(BMFCompletionBlock) completion;

@end
