//
//  TRNTableViewCell.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFTableViewCell.h"

@implementation BMFTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performInit];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		[self performInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self performInit];
    }
    return self;
}

/// Template method
- (void) performInit {
	self.imageViewContentMode = UIViewContentModeScaleAspectFit;
	
	[self reset];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
	CGFloat textX = self.margin.x;
	
	if (self.imageWidth!=-1 && self.imageView.image) {
		self.imageView.contentMode = self.imageViewContentMode;
		self.imageView.clipsToBounds = YES;
		self.imageView.frame = CGRectMake(self.margin.x,self.margin.y,self.imageWidth,self.bounds.size.height-self.margin.y*2);
		textX += self.imageView.bounds.size.width+self.margin.x;
	}
	
	CGRect textFrame = self.textLabel.frame;
	textFrame.origin.x = textX;
	textFrame.size.width = self.bounds.size.width-textFrame.origin.x;
	self.textLabel.frame = textFrame;
	
	self.separatorInset = UIEdgeInsetsMake(0, textFrame.origin.x, 0, 0);
}

//- (void) setDetailItem:(id)detailItem {
//	[NSException raise:@"Not implemented" format:@"You must implement setDetailItem to fill the cell"];
//}


- (void) reset {
	self.imageWidth = -1;
	self.margin = CGPointMake(10, 0);
	self.imageView.image = nil;
	self.textLabel.text = nil;
	self.detailTextLabel.text = nil;
	_detailItem = nil;
}


@end
