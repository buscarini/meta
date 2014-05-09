//
//  BMFCrossView.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFCrossView.h"

@implementation BMFCrossView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	
	//// Color Declarations
	UIColor* strokeColor = self.tintColor;
	
	//// Rectangle 2 Drawing
	UIBezierPath* rectangle2Path = [UIBezierPath bezierPath];
	[rectangle2Path moveToPoint: CGPointMake(83, 8)];
	[rectangle2Path addLineToPoint: CGPointMake(92, 17)];
	[rectangle2Path addLineToPoint: CGPointMake(17, 92)];
	[rectangle2Path addLineToPoint: CGPointMake(8, 82)];
	[rectangle2Path addLineToPoint: CGPointMake(83, 8)];
	[rectangle2Path closePath];
	[strokeColor setFill];
	[rectangle2Path fill];
	
	
	//// Rectangle Drawing
	UIBezierPath* rectanglePath = [UIBezierPath bezierPath];
	[rectanglePath moveToPoint: CGPointMake(83, 92)];
	[rectanglePath addLineToPoint: CGPointMake(92, 83)];
	[rectanglePath addLineToPoint: CGPointMake(17, 8)];
	[rectanglePath addLineToPoint: CGPointMake(8, 18)];
	[rectanglePath addLineToPoint: CGPointMake(83, 92)];
	[rectanglePath closePath];
	[strokeColor setFill];
	[rectanglePath fill];
}


@end
