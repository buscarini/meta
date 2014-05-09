//
//  BMFSubtitleTableViewCell.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSubtitleTableViewCell.h"

#import "BMF.h"

@implementation BMFSubtitleTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setLabelsMargin:(CGFloat)labelsMargin {
	for (NSLayoutConstraint *constraint in self.marginConstraints) {
		constraint.constant = labelsMargin;
	}
}

- (CGFloat) labelsMargin {
	NSLayoutConstraint *constraint = [NSLayoutConstraint BMF_cast:self.marginConstraints.firstObject];
	return constraint.constant;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
