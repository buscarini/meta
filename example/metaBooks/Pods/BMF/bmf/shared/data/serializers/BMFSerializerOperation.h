//
//  TNSerializerOperation.h
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import "BMFSerializerProtocol.h"

@interface BMFSerializerOperation : BMFAsyncOperation

- (instancetype) initWithSerializer:(id<BMFSerializerProtocol>)serializer;

@end
