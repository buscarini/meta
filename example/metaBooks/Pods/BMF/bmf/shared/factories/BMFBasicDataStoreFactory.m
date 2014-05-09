//
//  BMFBasicDataStoreFactory.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBasicDataStoreFactory.h"

#import "BMFDataReadProtocol.h"
#import "BMFArrayDataStore.h"

@implementation BMFBasicDataStoreFactory

+ (void)load {
	[self register];
}

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender {
	if ([input isKindOfClass:[NSArray class]]) {
		return [self arrayDataStore:input sender:sender];
	}
	
	return nil;
}

- (id<BMFDataReadProtocol>) arrayDataStore:(NSArray *) items sender:(id) sender {
	BMFArrayDataStore *ds = [BMFArrayDataStore new];
	ds.items = items;
	return ds;
}


@end
