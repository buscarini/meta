//
//  BMFOpenAppActivity.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivity.h"

@interface BMFOpenAppActivity : BMFActivity

@property (nonatomic, copy) NSURL *urlScheme;
@property (nonatomic, copy) NSURL *urlAppStore;

- (instancetype) initWithUrl:(NSURL *) urlScheme;

@end
