//
//  TRNColumnsLayoutDelegate.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/03/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFMatrixFlowLayoutDelegate.h"

@implementation BMFMatrixFlowLayoutDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
		self.numColumns = [[BMFDeviceValue alloc] initWithDefaultValue:@2];
		[self.numColumns setValue:@3 forFamily:BMFDeviceFamilyIPhone orientationAxis:BMFDeviceOrientationAxisLandscape];
		[self.numColumns setValue:@3 forFamily:BMFDeviceFamilyIPad];
		[self.numColumns setValue:@4 forFamily:BMFDeviceFamilyIPad orientationAxis:BMFDeviceOrientationAxisLandscape];
		
//        self.numColumns = 2;
//		self.numColumnsIPad = 3;
//		self.numColumnsLandscape = 3;
//		self.numColumnsLandscapeIPad = 4;
		
		self.outerMargin = 10;
		self.innerMargin = 10;
		self.itemAspectRatio = 1;
		
		self.verticalMode = BMFMatrixFlowLayoutDelegateVerticalModeRows;
		
		self.numRows = [[BMFDeviceValue alloc] initWithDefaultValue:@4];
		[self.numRows setValue:@2 forFamily:BMFDeviceFamilyIPhone orientationAxis:BMFDeviceOrientationAxisLandscape];
		[self.numRows setValue:@6 forFamily:BMFDeviceFamilyIPad];
		[self.numRows setValue:@4 forFamily:BMFDeviceFamilyIPad orientationAxis:BMFDeviceOrientationAxisLandscape];

		self.itemHeight = [[BMFDeviceValue alloc] initWithDefaultValue:@120];
		[self.itemHeight setValue:@70 forFamily:BMFDeviceFamilyIPhone orientationAxis:BMFDeviceOrientationAxisLandscape];
		[self.itemHeight setValue:@150 forFamily:BMFDeviceFamilyIPad];
		[self.itemHeight setValue:@120 forFamily:BMFDeviceFamilyIPad orientationAxis:BMFDeviceOrientationAxisLandscape];

		
		// self.numRows = 4;
// 		self.numRowsIPad = 6;
// 		self.numRowsLandscape = 2;
// 		self.numRowsLandscapeIPad = 4;
		
		self.itemAspectRatio = 1;
		
		// self.itemHeight = 120;
// 		self.itemHeightIPad = 150;
// 		self.itemHeightLandscape = 70;
// 		self.itemHeightLandscapeIPad = 120;
    }
    return self;
}

/*- (NSUInteger) deviceNumColumns {
	if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.numColumnsLandscapeIPad;
		}
		else {
			return self.numColumnsIPad;
		}
	}
	else {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.numColumnsLandscape;
		}
		else {
			return self.numColumns;
		}
	}
}

- (CGFloat) deviceNumRows {
	if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.numColumnsLandscapeIPad;
		}
		else {
			return self.numRowsIPad;
		}
	}
	else {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.numRowsLandscape;
		}
		else {
			return self.numRows;
		}
	}
}

- (CGFloat) deviceItemHeight {
	if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.itemHeightLandscapeIPad;
		}
		else {
			return self.itemHeightIPad;
		}
	}
	else {
		if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
			return self.itemHeightLandscape;
		}
		else {
			return self.itemHeight;
		}
	}
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	CGFloat itemWidth = [self itemWidth:collectionView.bounds.size.width];
		
	CGFloat itemHeight = [self itemHeight:itemWidth totalHeight:collectionView.bounds.size.height];
	
	return CGSizeMake(itemWidth, itemHeight);
}

- (CGFloat) itemWidth:(CGFloat) totalWidth {
	NSUInteger finalNumColumns = [[self.numColumns currentValue] integerValue];
	
	NSUInteger numOuterMargins = 2;
	NSUInteger numInnerMargins = finalNumColumns-1;
	
	return (totalWidth-(numOuterMargins*self.outerMargin+numInnerMargins*self.innerMargin))/finalNumColumns;
}

- (CGFloat) itemHeight:(CGFloat) itemWidth totalHeight:(CGFloat) totalHeight {
	if (self.verticalMode==BMFMatrixFlowLayoutDelegateVerticalModeFixed) {
		return [[self.itemHeight currentValue] floatValue];
	}
	else if (self.verticalMode==BMFMatrixFlowLayoutDelegateVerticalModeAspectRatio) {
		CGFloat aspectRatio = self.itemAspectRatio;
		if (aspectRatio==0) aspectRatio = 1;
		return itemWidth/aspectRatio;
	}
	else {
		NSUInteger finalNumRows = [[self.numRows currentValue] integerValue];
		
		NSUInteger numOuterMargins = 2;
		NSUInteger numInnerMargins = finalNumRows-1;
		
		return (totalHeight-(numOuterMargins*self.outerMargin+numInnerMargins*self.innerMargin))/finalNumRows;
	}
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(self.outerMargin, self.outerMargin, self.outerMargin, self.outerMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return self.innerMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return self.innerMargin;
}

@end
