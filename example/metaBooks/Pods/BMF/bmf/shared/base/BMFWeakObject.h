//
//  BMFWeakObject.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFWeakObject : NSObject

@property (nonatomic, weak) id object;

- (instancetype) initWithObject:(id) object;
- (BOOL) isEqual:(id)object;

@end
