//
//  BMFValueProtocol.h
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFValueProtocol <NSObject>

/// Block run when the value might have changed. Setting the block also runs it immediately
@property (nonatomic, strong) BMFActionBlock applyValueBlock;

/// Retrieves the current value
- (id) currentValue;

@end
