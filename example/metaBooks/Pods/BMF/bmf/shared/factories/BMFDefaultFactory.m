//
//  BMFDefaultFactory.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 04/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDefaultFactory.h"

/// Load Tasks

#import "BMFOperationsTask.h"
#import "BMFLoaderOperation.h"
#import "BMFAFURLSessionLoader.h"
#import "BMFFileLoader.h"

/// Serializers
#import "BMFSerializerOperation.h"
#import "BMFJSONSerializer.h"
#import "BMFImageSerializer.h"

#import "BMFDataStoreFactory.h"



static NSArray *networkFactories = nil;
static NSArray *dataStoreFactories = nil;

@implementation BMFDefaultFactory

+ (void) initialize {
	dataStoreFactories = [BMFDataStoreFactory availableFactories];
}

#pragma mark Network

- (id) loaderWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender {
	BMFAFURLSessionLoader *loader = [BMFAFURLSessionLoader new];
	
	loader.url = [NSURL URLWithString:urlString];
	loader.parameters = parameters;
	
	return loader;
}

- (id) loaderOperationWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender {
	return [[BMFLoaderOperation alloc] initWithLoader:[self loaderWithUrlString:urlString parameters:parameters sender:sender]];
}

- (id) fileLoaderWithUrl:(NSURL *) fileURL {
	BMFFileLoader *loader = [BMFFileLoader new];
	loader.fileUrl = fileURL;
	return loader;
}

- (id) fileLoaderOperationWithUrl:(NSURL *) fileURL sender:(id) sender {
	return [[BMFLoaderOperation alloc] initWithLoader:[self fileLoaderWithUrl:fileURL]];
}


- (id<BMFTaskProtocol>) dataLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender {
	
	BMFOperation *loadOperation = [self loaderOperationWithUrlString:urlString parameters:parameters sender:sender];
	
	id<BMFTaskProtocol> task = [[BMFOperationsTask alloc] initWithOperations:@[ loadOperation ]];
	return task;
}

- (id<BMFTaskProtocol>) imageLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender {
	
	BMFOperation *loadOperation = [self loaderOperationWithUrlString:urlString parameters:parameters sender:sender];
	
	BMFOperation *serializeOperation = [self imageSerializerOperation:sender];
	
	id<BMFTaskProtocol> task = [[BMFOperationsTask alloc] initWithOperations:@[ loadOperation, serializeOperation ]];
	
	return task;
}

#pragma mark Serializers
- (id<BMFSerializerProtocol>) jsonSerializer:(id)sender {
	return [BMFJSONSerializer new];
}

- (id<BMFSerializerProtocol>) imageSerializer:(id)sender{
	return [BMFImageSerializer new];
}

- (BMFOperation *) jsonSerializerOperation:(id)sender {
	return [[BMFSerializerOperation alloc] initWithSerializer:[self jsonSerializer:(id)sender]];
}

- (BMFOperation *) imageSerializerOperation:(id)sender {
	return [[BMFSerializerOperation alloc] initWithSerializer:[self imageSerializer:(id)sender]];
}


#pragma mark Data Stores

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender {
	for (id<BMFDataStoresFactoryProtocol> factory in dataStoreFactories) {
		id object = [factory dataStoreWithParameter:input sender:sender];
		if (object) return object;
	}
	
	return nil;
}

- (id<BMFDataReadProtocol>) dataStoreWithParameters:(NSArray *) parameters sender:(id) sender {
	if (parameters.count==1) return [self dataStoreWithParameter:parameters.firstObject sender:sender];
	
	for (id<BMFDataStoresFactoryProtocol> factory in dataStoreFactories) {
		id object = [factory dataStoreWithParameters:parameters sender:sender];
		if (object) return object;
	}
	
	return nil;
}


@end
