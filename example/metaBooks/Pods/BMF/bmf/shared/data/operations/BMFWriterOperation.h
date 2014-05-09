//
//  BMFWriterOperation.h
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import "BMFWriterProtocol.h"

@interface BMFWriterOperation : BMFAsyncOperation

- (instancetype) initWithWriter:(id<BMFWriterProtocol>) writer;

@end
