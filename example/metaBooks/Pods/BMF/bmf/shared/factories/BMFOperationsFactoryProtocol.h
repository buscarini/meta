//
//  BMFOperationsFactoryProtocol.h
//  BMFMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFSerializerProtocol.h"

@class BMFOperation;

@protocol BMFOperationsFactoryProtocol <NSObject>

- (id<BMFSerializerProtocol>) jsonSerializer:(id)sender;
- (id<BMFSerializerProtocol>) imageSerializer:(id)sender;

#pragma mark Serializers
- (BMFOperation *) jsonSerializerOperation:(id)sender;
- (BMFOperation *) imageSerializerOperation:(id)sender;

@end
