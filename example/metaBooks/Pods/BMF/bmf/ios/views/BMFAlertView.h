//
//  BMFAlertView.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFTypes.h"

@interface BMFAlertView : UIAlertView

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message;

- (void) BMF_addButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block;
- (void) BMF_addCancelButtonWithActionBlock:(BMFActionBlock)block;
- (void) BMF_addCancelButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block;

@end
