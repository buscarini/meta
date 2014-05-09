//
//  BMFViewControllerDataSourceProtocol.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataReadProtocol.h"

@protocol BMFViewControllerDataSourceProtocol <NSObject>

@property (nonatomic, strong) id<BMFDataReadProtocol> dataSource;

@end
