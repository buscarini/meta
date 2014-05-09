//
//  NSIndexPath+BMF.m
//  BMFMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import "NSIndexPath+BMF.h"

@implementation NSIndexPath (BMF)

+ (NSIndexPath *) BMF_indexPathForRow:(NSInteger)row inSection:(NSInteger) section {
#if TARGET_OS_IPHONE
	return [NSIndexPath indexPathForRow:row inSection:section];
	
#else
	return [NSIndexPath indexPathWithIndex:row];
#endif
}

- (NSInteger) BMF_section {
#if TARGET_OS_IPHONE
	return self.section;
#else
	return 0;
#endif
}

- (NSInteger) BMF_row {
#if TARGET_OS_IPHONE
	return self.row;
#else
	return [self indexAtPosition:0];
#endif
}


@end
