//
//  BMFFixedValueChooser.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValueChooser.h"

@interface BMFFixedValueChooser : BMFValueChooser

/// Index will be used if it is sent an array, 0 by default
@property (nonatomic, assign) NSInteger index;

/// Key will be used if it is sent a dictionary. If no key it will use the first value
@property (nonatomic, copy) NSString *key;

@end
