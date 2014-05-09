//
//  TRNSimpleLoaderView.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFView.h"

#import "BMFLoaderViewProtocol.h"

@interface BMFSimpleLoaderView : BMFView <BMFLoaderViewProtocol>

@property (nonatomic, strong) NSString *message;

@property (nonatomic, copy) BMFActionBlock reloadActionBlock;
@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, assign) NSInteger crossHideDelay;

@property (nonatomic, strong) UIActivityIndicatorView *loaderView;

- (void) addToViewController:(UIViewController *) vc;

@end
