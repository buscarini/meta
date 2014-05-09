//
//  TNLoaderOperation.h
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import "BMfLoaderProtocol.h"

@interface BMFLoaderOperation : BMFAsyncOperation

- (instancetype) initWithLoader:(id<BMFLoaderProtocol>) loader;

@property (readonly, nonatomic) id<BMFLoaderProtocol> loader;

@end
