//
//  TRNAutoLayoutUtils.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@interface BMFAutoLayoutUtils : NSObject

+ (NSArray *) fill:(BMFIXView *)view parent:(BMFIXView *) parent margin:(CGFloat) margin;
+ (NSArray *) fill:(BMFIXView *)view parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority;
+ (NSArray *) fillHorizontally:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin;
+ (NSArray *) fillVertically:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin;
+ (NSArray *) fillHorizontally:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority;
+ (NSArray *) fillVertically:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority;

+ (NSArray *) constraint:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin;
+ (NSArray *) constraintHorizontally:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority;
+ (NSArray *) constraintVertically:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority;

+ (NSArray *) centerView:(BMFIXView *) view inParent:(BMFIXView *)parent;
+ (NSArray *) centerVertically:(NSArray *) views inParent:(BMFIXView *)parent margin:(CGFloat) margin;
+ (NSArray *) centerHorizontally:(NSArray *) views inParent:(BMFIXView *)parent margin:(CGFloat) margin;

+ (NSArray *) distributeHorizontally: (NSArray *)views inParent:(BMFIXView *)parent margin:(CGFloat) margin;
+ (NSArray *) distributeVertically: (NSArray *)views inParent:(BMFIXView *)parent margin:(CGFloat) margin;

+ (void) sizeEqualContent: (BMFIXView *) view;
+ (void) sizeGreaterEqualContent: (BMFIXView *) view;
+ (void) sizeSmallerEqualContent: (BMFIXView *) view;

+ (NSArray *) sizeEqual: (BMFIXView *) view constant:(CGSize) size;
+ (NSArray *) sizeEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority;
+ (NSLayoutConstraint *) widthEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSLayoutConstraint *) widthEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;
+ (NSLayoutConstraint *) heightEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSLayoutConstraint *) heightEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;

+ (NSArray *) sizeLessOrEqual: (BMFIXView *) view constant:(CGSize) size;
+ (NSArray *) sizeLessOrEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority;
+ (NSArray *) widthLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSArray *) widthLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;
+ (NSArray *) heightLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSArray *) heightLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;

+ (NSArray *) sizeGreaterOrEqual: (BMFIXView *) view constant:(CGSize) size;
+ (NSArray *) sizeGreaterOrEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority;
+ (NSLayoutConstraint *) widthGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSLayoutConstraint *) widthGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;
+ (NSLayoutConstraint *) heightGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant;
+ (NSLayoutConstraint *) heightGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority;

+ (NSArray *) equalWidths: (NSArray *)views;
+ (NSArray *) equalHeights: (NSArray *)views;
+ (NSArray *) equalWidths: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalHeights: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalWidths: (NSArray *)views inParent:(BMFIXView *)parent priority:(BMFLayoutPriority)priority;
+ (NSArray *) equalHeights: (NSArray *)views inParent:(BMFIXView *)parent priority:(BMFLayoutPriority)priority;

+ (NSArray *) equalTops: (NSArray *)views;
+ (NSArray *) equalTops: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalBottoms: (NSArray *)views;
+ (NSArray *) equalBottoms: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalLefts: (NSArray *)views;
+ (NSArray *) equalLefts: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalRights: (NSArray *)views;
+ (NSArray *) equalRights: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalCenters: (NSArray *)views;
+ (NSArray *) equalCenters: (NSArray *)views inParent:(BMFIXView *)parent;
+ (NSArray *) equalAttributes: (NSArray *)views parent:(BMFIXView *)parent attribute:(NSLayoutAttribute)attribute margin:(CGFloat)margin priority:(BMFLayoutPriority) priority;

+ (NSLayoutConstraint *) copyConstraint:(NSLayoutConstraint *) constraint;

+ (NSArray *) changeConstraint:(NSLayoutConstraint *) constraint parent:(BMFIXView *) parent priority:(BMFLayoutPriority) priority;

+ (void) setContentCompressionResistance:(BMFIXView *) view priority:(BMFLayoutPriority) priority axis:(BMFLayoutConstraintAxis) axis;
+ (void) setContentHugging:(BMFIXView *) view priority:(BMFLayoutPriority) priority axis:(BMFLayoutConstraintAxis) axis;

@end
