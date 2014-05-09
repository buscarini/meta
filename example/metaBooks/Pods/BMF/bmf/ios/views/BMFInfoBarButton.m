//
//  BMFInfoBarButton.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFInfoBarButton.h"

#import "BMF.h"

@implementation BMFInfoBarButton

+ (BMFInfoBarButton *) button {
	UIImage *image = [[BMFBase sharedInstance] imageNamed:@"info"];
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	return [[BMFInfoBarButton alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
