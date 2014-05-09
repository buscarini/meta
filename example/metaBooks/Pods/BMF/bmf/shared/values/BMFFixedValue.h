//
//  BMFFixedValue.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFValue.h"

@interface BMFFixedValue : BMFValue

@property (nonatomic, strong) id value;

- (instancetype) initWithValue:(id) value;

@end
