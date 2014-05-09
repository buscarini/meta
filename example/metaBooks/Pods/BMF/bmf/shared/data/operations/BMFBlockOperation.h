//
//  BMFBlockOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import "BMFTypes.h"

@interface BMFBlockOperation : BMFAsyncOperation

@property (nonatomic, copy) BMFOperationBlock block;

- (instancetype) initWithBlock: (BMFOperationBlock) block;

@end
