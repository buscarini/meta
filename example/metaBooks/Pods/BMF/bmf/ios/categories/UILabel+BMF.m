//
//  UILabel+BMF.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "UILabel+BMF.h"

@implementation UILabel (BMF)

- (void) BMF_setFontSizeWithAnimation:(CGFloat) fontSize duration:(CGFloat) duration {
	
	static const CGFloat lowValue = 0.0001;
	
	UIFont *oldFont = self.font;
	UIFont *newFont = [oldFont fontWithSize:fontSize];
	
	CGFloat oldFontSize = oldFont.pointSize;

	CGFloat pct = 1;
	
	if (fontSize>0) pct = oldFontSize/fontSize;
	else pct = oldFontSize/lowValue;
	if (pct==0) pct = lowValue;
	
	CGAffineTransform oldTransform = self.transform;
	
	if (fontSize>oldFontSize) {
		self.font = newFont;
		self.transform = CGAffineTransformScale(self.transform, pct, pct);
		[self sizeToFit];
		
	}
	
	[UIView animateWithDuration:duration animations:^{
		self.transform = CGAffineTransformScale(self.transform, 1/pct, 1/pct);
	} completion:^(BOOL finished) {
		
		self.font = newFont;
		self.transform = oldTransform;
		
		[self sizeToFit];
	}];
}

@end
