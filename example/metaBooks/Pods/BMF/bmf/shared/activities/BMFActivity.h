//
//  BMFActivity.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFActionableProtocol.h"

#import "BMFActivityProtocol.h"
#import "BMFGroup.h"

@interface BMFActivity : BMFGroup <BMFActivityProtocol,BMFActionableProtocol>

/// Optional, but some activities might require a view controller to work
#if TARGET_OS_IPHONE
@property (nonatomic, weak) UIViewController *viewController;
#endif

/// Value formatted in a presentable way to the user. Can be set or the activity might provide it
@property (nonatomic, strong) NSString *localizedValue;

@property (nonatomic, strong) id value;

@property (readonly, nonatomic) BOOL isAvailable;

- (void) run: (BMFCompletionBlock) completionBlock;

#pragma mark Actionable

- (void) action:(id)input completion:(BMFCompletionBlock)completion;

@end
