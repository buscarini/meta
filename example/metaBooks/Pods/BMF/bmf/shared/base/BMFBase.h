//
//  BMFBase.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//


#import "BMFPlatform.h"

#import "BMFTypes.h"

#import "BMFDefaultFactory.h"

#if TARGET_OS_IPHONE
#import "BMFIOSDefaultFactory.h"
#endif

@class BMFKeyboardManager;

@interface BMFBase : NSObject

/// Queue for background processing
@property (nonatomic, strong) NSOperationQueue *backgroundQueue;

/// Queue for network operations
@property (nonatomic, strong) NSOperationQueue *networkQueue;

/// Queue for high priority operations, mainly related to ui actions and such
@property (nonatomic, strong) NSOperationQueue *highPriorityQueue;


@property (nonatomic, strong) NSBundle *bundle;

#if TARGET_OS_IPHONE
@property (nonatomic, strong) BMFKeyboardManager *keyboardManager;
@property (nonatomic, weak) UIStoryboard *storyboard;
@property (nonatomic, strong) BMFIOSDefaultFactory *factory;
#else
@property (nonatomic, strong) BMFDefaultFactory *factory;
#endif

@property (nonatomic, readonly) id<BMFConfigurationProtocol> config;

+ (BMFBase *) sharedInstance;

- (void) loadConfig:(id<BMFConfigurationProtocol>) config;

- (BMFIXImage *) imageNamed:(NSString *) imageName;

@end
