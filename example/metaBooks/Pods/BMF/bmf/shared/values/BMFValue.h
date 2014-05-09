//
//  BMFValue.h
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValueProtocol.h"

@interface BMFValue : NSObject <BMFValueProtocol>

/// Block run when the value might have changed
@property (nonatomic, strong) BMFActionBlock applyValueBlock;

/// Used by subclasses to prepare the value for delivery. Transforms nsnull to nil, and if the value is a bmfvalue gets its currentvalue
- (id) prepareValue:(id) value;

@end
