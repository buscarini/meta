//
//  BMFWeakDictionary.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFMutableWeakDictionary.h"
#import "BMFWeakObject.h"

@interface BMFMutableWeakDictionary()

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation BMFMutableWeakDictionary

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) setObject:(id)object forKey:(id)aKey {
	BMFWeakObject *obj = [[BMFWeakObject alloc] initWithObject:object];
	[self.dic setObject:obj forKey:aKey];
}

- (id) objectForKey:(id)aKey {
	BMFWeakObject *weak = [self.dic objectForKey:aKey];
	
	if (!weak.object) [self.dic removeObjectForKey:aKey];
	return weak.object;
}

- (void) setObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
	BMFWeakObject *obj = [[BMFWeakObject alloc] initWithObject:object];
	[self.dic setObject:obj forKeyedSubscript:key];
}

- (id) objectForKeyedSubscript:(id<NSCopying>)key {
	BMFWeakObject *weak = [self.dic objectForKeyedSubscript:key];

	if (!weak.object) {
		[self.dic removeObjectForKey:key];
	}
	
	return weak.object;
}

- (NSArray *) allKeys {	
	NSArray *allKeys = [[self.dic allKeys] copy];
	
	for (NSString *key in allKeys) {
		BMFWeakObject *weak = self.dic[key];
		if (!weak.object) [self.dic removeObjectForKey:key];
	}
	
	return self.dic.allKeys;
}

@end
