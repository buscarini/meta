//
//  BMFAnimationUtils.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFAnimationUtils.h"

#import <QuartzCore/QuartzCore.h>

#import <AudioToolbox/AudioServices.h>

@implementation BMFAnimationUtils

+ (void) harlemShake:(CALayer *) layer vibrate:(BOOL) vibrate {
	CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	[anim setToValue:[NSNumber numberWithFloat:-0.05f]];
	[anim setFromValue:[NSNumber numberWithFloat:0.05f]];
	[anim setDuration:0.09f];
	[anim setRepeatCount:2];
	[anim setAutoreverses:YES];

	layer.shouldRasterize = NO;
	[layer addAnimation:anim forKey:@"HarlemShake"];
	
	#if TARGET_OS_IPHONE
	if (vibrate) AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	#endif
}

@end
