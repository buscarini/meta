//
//  NSBundle+BMF.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 19/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "NSBundle+BMF.h"

@implementation NSBundle (BMF)

+ (NSBundle *) BMF_bundle {
	return [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"BMF" withExtension:@"bundle"]];
}

@end
