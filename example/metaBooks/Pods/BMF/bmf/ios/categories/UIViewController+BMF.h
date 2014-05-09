//
//  UIViewController+BMFUtils.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFTypes.h"

@interface UIViewController (BMF)

- (void) BMF_addChild:(UIViewController *) detailVC addSubviewBlock:(BMFActionBlock) block;

@end
