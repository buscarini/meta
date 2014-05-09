//
//  BMFActivityProtocol.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFActivityProtocol <NSObject>

/// Optional, but some activities might require a view controller to work
#if TARGET_OS_IPHONE
@property (nonatomic, weak) UIViewController *viewController;
#endif

/// Value formatted in a presentable way to the user. Can be set or the activity might provide it
@property (nonatomic, strong) NSString *localizedValue;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

/// If this activity is available for the platform or device or with the current settings
@property (readonly, nonatomic) BOOL isAvailable;

- (void) run: (BMFCompletionBlock) completionBlock;

@end
