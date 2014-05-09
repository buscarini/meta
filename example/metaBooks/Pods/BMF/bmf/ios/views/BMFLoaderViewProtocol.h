//
//  BMFLoaderViewProtocol.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"
#import "BMFProgress.h"

@protocol BMFLoaderViewProtocol <NSObject>

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, copy) BMFActionBlock reloadActionBlock;

- (void) addToViewController:(UIViewController *) vc;

@end
