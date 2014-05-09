//
//  BMFValueArray.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValue.h"
#import "BMFValueChooser.h"

@interface BMFValueArray : BMFValue

@property (nonatomic, strong) NSArray *values;

/// Class that allows to change the value each time something happens
@property (nonatomic, strong) BMFValueChooser *valueChooser;

- (instancetype) initWithValues:(NSArray *) values;

@end
