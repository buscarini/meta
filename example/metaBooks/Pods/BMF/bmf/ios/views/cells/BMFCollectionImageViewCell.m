//
//  BMFCollectionImageViewCell.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCollectionImageViewCell.h"

#import "BMFAutoLayoutUtils.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFCollectionImageViewCell

- (void) performInit {
	
	self.imageView = [UIImageView new];
	self.imageView.userInteractionEnabled = YES;
	[self addSubview:self.imageView];
	self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	[BMFAutoLayoutUtils fill:self.imageView parent:self margin:0];
}

@end
