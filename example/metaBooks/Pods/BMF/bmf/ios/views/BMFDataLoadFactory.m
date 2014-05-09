//
//  BMFDataLoadFactory.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDataLoadFactory.h"

// Task

#import "BMFOperationsTask.h"

// Loader
#import "BMFLoaderOperation.h"
#import "BMFAFURLSessionLoader.h"

// Serializer
#import "BMFJSONSerializer.h"
#import "BMFSerializerOperation.h"

// Parser


// Debug
#import "BMFLogOperation.h"


@implementation BMFDataLoadFactory

#pragma mark Loader

- (NSURL *) url {
	return [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/72768/public/test.json"];
}

- (id<BMFLoaderProtocol>) loader {
	BMFAFURLSessionLoader *instance = [BMFAFURLSessionLoader new];
	
	instance.url = [self url];
	
	return instance;
}

- (BMFOperation *) loaderOperation {
	BMFLoaderOperation *operation = [[BMFLoaderOperation alloc] initWithLoader:[self loader]];
	return operation;
}

#pragma mark Serializer

- (id<BMFSerializerProtocol>) serializer {
	return [[BMFJSONSerializer alloc] init];
}

- (BMFOperation *) serializerOperation {
	BMFSerializerOperation *operation = [[BMFSerializerOperation alloc] initWithSerializer:[self serializer]];
	return operation;
}

#pragma mark Task

- (id<BMFTaskProtocol>) dataLoadTask {
	
	NSMutableArray *operations = [NSMutableArray array];
	
	BMFOperation *loadOperation = [self loaderOperation];
	[operations addObject:loadOperation];
	
	BMFOperation *serializerOperation = [self serializerOperation];
	[serializerOperation addDependency:loadOperation];
	[operations addObject:serializerOperation];
	
	BMFOperation *logOp = [BMFLogOperation new];
	[logOp addDependency:serializerOperation];
	[operations addObject:logOp];
	
	id<BMFTaskProtocol> task = [[BMFOperationsTask alloc] initWithOperations:operations];
	return task;
}



@end
