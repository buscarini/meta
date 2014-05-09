//
//  BMFLoaderBarItem.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFBarButtonItem.h"
#import "BMFLoaderViewProtocol.h"

@interface BMFLoaderBarItem : BMFBarButtonItem <BMFLoaderViewProtocol>

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, copy) BMFActionBlock reloadActionBlock;

@property (nonatomic, strong) UIActivityIndicatorView *loaderView;

@property (nonatomic, assign) BOOL isRightButton; // YES will add the button to the right, NO to the left if addToViewController is used

- (void) addToViewController:(UIViewController *) vc;

+ (BMFLoaderBarItem *) barItem;

@end
