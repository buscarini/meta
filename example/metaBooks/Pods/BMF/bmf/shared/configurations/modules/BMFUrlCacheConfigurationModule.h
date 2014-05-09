//
//  BMFUrlCacheConfigurationModule.h
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFConfigurationProtocol.h"

@interface BMFUrlCacheConfigurationModule : NSObject <BMFConfigurationProtocol>

@property (nonatomic, assign) int cacheMemorySize;
@property (nonatomic, assign) int cacheDiskSize;

@end
