//
//  TRNColumnsLayoutDelegate.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/03/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDeviceValue.h"

typedef enum : NSUInteger {
	BMFMatrixFlowLayoutDelegateVerticalModeRows,
    BMFMatrixFlowLayoutDelegateVerticalModeFixed,
    BMFMatrixFlowLayoutDelegateVerticalModeAspectRatio
} BMFMatrixFlowLayoutDelegateVerticalMode;

@interface BMFMatrixFlowLayoutDelegate : NSObject <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BMFDeviceValue *numColumns;

/*/// 2 by default
@property (nonatomic, assign) NSUInteger numColumns;

/// 3 by default
@property (nonatomic, assign) NSUInteger numColumnsIPad;

/// 3 by default
@property (nonatomic, assign) NSUInteger numColumnsLandscape;

/// 4 by default
@property (nonatomic, assign) NSUInteger numColumnsLandscapeIPad;
*/

/// Margin to the edges of a section. 10 by default
@property (nonatomic, assign) CGFloat outerMargin;

/// Margin between items. 10 by default
@property (nonatomic, assign) CGFloat innerMargin;

/// Defines how to calculate the height of each item
@property (nonatomic, assign) BMFMatrixFlowLayoutDelegateVerticalMode verticalMode;

@property (nonatomic, strong) BMFDeviceValue *numRows;
@property (nonatomic, strong) BMFDeviceValue *itemHeight;

/// Num rows in screen for TRNColumnsLayoutDelegateVerticalModeRows vertical mode
/*@property (nonatomic, assign) NSUInteger numRows;
@property (nonatomic, assign) NSUInteger numRowsIPad;
@property (nonatomic, assign) NSUInteger numRowsLandscape;
@property (nonatomic, assign) NSUInteger numRowsLandscapeIPad;

/// Fixed height of each item for TRNColumnsLayoutDelegateVerticalModeFixed vertical mode
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemHeightIPad;
@property (nonatomic, assign) CGFloat itemHeightLandscape;
@property (nonatomic, assign) CGFloat itemHeightLandscapeIPad;*/


/// Aspect ratio of each item for TRNColumnsLayoutDelegateVerticalModeAspectRatio vertical mode
@property (nonatomic, assign) CGFloat itemAspectRatio;

@end
