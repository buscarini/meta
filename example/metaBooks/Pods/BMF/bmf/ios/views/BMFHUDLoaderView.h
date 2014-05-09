//
//  BMFHUDLoaderView.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFView.h"

#import "BMFLoaderViewProtocol.h"

@interface BMFHUDLoaderView : BMFView <BMFLoaderViewProtocol>

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, copy) BMFActionBlock reloadActionBlock;

@property (nonatomic, strong) UIActivityIndicatorView *loaderView;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, assign) NSInteger crossHideDelay;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, strong) UIFont *font;

- (void) addToViewController:(UIViewController *) vc;


@end
