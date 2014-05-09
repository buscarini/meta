//
//  BMFDefaultFactory.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 04/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFNetworkFactoryProtocol.h"
#import "BMFOperationsFactoryProtocol.h"
#import "BMFDataStoresFactoryProtocol.h"
#import "BMFSerializerProtocol.h"

@protocol BMFTaskProtocol;

@protocol BMFDataReadProtocol;

@class BMFOperation;

@protocol BMFDataSourceProtocol;

@interface BMFDefaultFactory : NSObject <BMFNetworkFactoryProtocol, BMFOperationsFactoryProtocol,BMFDataStoresFactoryProtocol>

#pragma mark Network

- (id) loaderWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;
- (id) loaderOperationWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;

- (id) fileLoaderOperationWithUrl:(NSURL *) fileURL sender:(id) sender;

- (id<BMFTaskProtocol>) dataLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;
- (id<BMFTaskProtocol>) imageLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;

#pragma mark Operations

- (id<BMFSerializerProtocol>) jsonSerializer:(id)sender;
- (id<BMFSerializerProtocol>) imageSerializer:(id)sender;

- (BMFOperation *) jsonSerializerOperation:(id)sender;
- (BMFOperation *) imageSerializerOperation:(id)sender;

#pragma mark Data Stores

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender;
- (id<BMFDataReadProtocol>) dataStoreWithParameters:(NSArray *) parameters sender:(id) sender;



@end
