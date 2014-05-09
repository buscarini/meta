//
//  BMFDataStoreFactory.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFDataStoreFactory : NSObject

+ (NSArray *) availableFactories;
+ (void) register;
+ (void) unregister;

@end
