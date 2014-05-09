//
//  BMFParserOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import "BMFParserProtocol.h"

@interface BMFParserOperation : BMFAsyncOperation

- (instancetype) initWithParser:(id<BMFParserProtocol>) parser;

@end
