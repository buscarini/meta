//
//  UICollectionView+BMF.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "UICollectionView+BMF.h"

@implementation UICollectionView (BMF)

- (void) BMF_updateDelegate:(id)delegate {
	self.delegate = nil;
	self.delegate = delegate;
}

+ (NSString *) BMF_kindStringFromKind:(BMFViewKind) kind {
	NSString *kindString = UICollectionElementKindSectionHeader;
	if (kind==BMFViewKindSectionFooter) kindString = UICollectionElementKindSectionFooter;
	return kindString;
}

+ (BMFViewKind) BMF_kindFromKindString:(NSString *) kindString {
	BMFViewKind kind = BMFViewKindSectionHeader;
	if ([kindString isEqualToString:UICollectionElementKindSectionFooter]) kind = BMFViewKindSectionFooter;
	return kind;
}


@end
