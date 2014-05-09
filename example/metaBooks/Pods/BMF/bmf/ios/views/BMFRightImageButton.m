//
//  TRNRightImageButton.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFRightImageButton.h"

@implementation BMFRightImageButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    frame.origin.x = CGRectGetMaxX(contentRect) - CGRectGetWidth(frame) -  self.imageEdgeInsets.right + self.imageEdgeInsets.left;
    return frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = CGRectGetMinX(frame) - CGRectGetWidth([self imageRectForContentRect:contentRect]);
    return frame;
}

@end
