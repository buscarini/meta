//
//  BMFConditionalActivity.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFConditionalValue.h"

#import "BMFActivityProtocol.h"

@interface BMFConditionalActivity : BMFConditionalValue <BMFActivityProtocol>

#if TARGET_OS_IPHONE
@property (nonatomic, weak) UIViewController *viewController;
#endif

/// Value formatted in a presentable way to the user. Can be set or the activity might provide it
@property (nonatomic, strong) NSString *localizedValue;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

/// If this activity is available for the platform or device or with the current settings
@property (readonly, nonatomic) BOOL isAvailable;

- (instancetype) initWithDefaultActivity:(id<BMFActivityProtocol>) defaultActivity;

- (void) run: (BMFCompletionBlock) completionBlock;

@end
