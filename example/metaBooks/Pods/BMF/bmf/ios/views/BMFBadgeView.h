//
//  BMFBadgeView.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 28/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFView.h"

@interface BMFBadgeView : BMFView

@property (nonatomic, copy) NSString *badgeString;
@property (nonatomic, strong) UIColor *badgeColor;
@property (nonatomic, strong) UIColor *badgeTextColor;

@end
