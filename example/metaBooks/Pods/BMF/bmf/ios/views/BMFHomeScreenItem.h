//
//  TRNHomeScreenItem.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFView.h"

#import "BMFActionLabel.h"

#import "BMFTypes.h"

// Looks like any iOS app in the home screen

@interface BMFHomeScreenItem : BMFView

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) BMFActionLabel *textLabel;

@property (nonatomic, copy) BMFActionBlock actionBlock;

@property (nonatomic, copy) NSString *badgeString;
@property (nonatomic, strong) UIColor *badgeColor;
@property (nonatomic, strong) UIColor *badgeTextColor;

@end
