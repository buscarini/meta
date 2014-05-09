//
//  BMFBlockActivity.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivity.h"

typedef void (^BMFBlockActivityBlock)(id sender,id value,BMFCompletionBlock completionBlock);

@interface BMFBlockActivity : BMFActivity

@property (nonatomic, copy) BMFBlockActivityBlock block;

- (instancetype) initWithBlock:(BMFBlockActivityBlock) block;

@end
