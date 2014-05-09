//
//  BMFWeakDictionary.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFMutableWeakDictionary : NSObject

- (void) setObject:(id)object forKey:(id)aKey;
- (id) objectForKey:(id)aKey;

- (void) setObject:(id)object forKeyedSubscript:(id<NSCopying>)subscript;
- (id) objectForKeyedSubscript:(id<NSCopying>)subscript;

- (NSArray *) allKeys;

@end
