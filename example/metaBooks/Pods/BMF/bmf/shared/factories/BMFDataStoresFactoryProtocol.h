//
//  BMFDataStoresFactoryProtocol.h
//  BMFMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataReadProtocol.h"


@protocol BMFDataStoresFactoryProtocol <NSObject>

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender;
- (id<BMFDataReadProtocol>) dataStoreWithParameters:(NSArray *) parameters sender:(id) sender;

@end
