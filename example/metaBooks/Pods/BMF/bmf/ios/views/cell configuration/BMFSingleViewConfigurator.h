//
//  BMFCellConfigurator.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 01/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "BMFViewConfigurator.h"
#import "BMFViewConfiguratorProtocol.h"

@interface BMFSingleViewConfigurator : BMFViewConfigurator <BMFViewConfiguratorProtocol>

/// Template class methods
+ (Class) viewClass;
+ (Class) itemClass;

@end
