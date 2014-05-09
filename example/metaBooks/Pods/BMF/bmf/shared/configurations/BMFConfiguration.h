//
//  BMFConfiguration.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFConfigurationProtocol.h"

@interface BMFConfiguration : NSObject <BMFConfigurationProtocol>

@property (nonatomic, readonly) NSArray *modules;

- (void) addModule:(id<BMFConfigurationProtocol>)module;


@end
