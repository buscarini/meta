//
//  BMFRoundRobinValueChooser.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValueChooser.h"

@interface BMFRoundRobinValueChooser : BMFValueChooser

@property (nonatomic, assign) NSInteger index;

@end
