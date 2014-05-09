//
//  BMFMapZoomer.h
//  DataSources
//
//  Created by José Manuel Sánchez on 29/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFMapZoomerProtocol.h"

@interface BMFMapZoomer : NSObject <BMFMapZoomerProtocol>

@property (nonatomic, assign) BOOL includeOverlays;

/// Adjusts zooming adding a margin
@property (nonatomic, assign) CGFloat zoomPctIncrease;
@property (nonatomic, assign) CGFloat minimumSpan;

@end
