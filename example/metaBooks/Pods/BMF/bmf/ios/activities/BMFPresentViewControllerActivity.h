//
//  BMFPresentViewControllerActivity.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivity.h"

typedef enum : NSUInteger {
    BMFPresentViewControllerActivityModeSegue,
    BMFPresentViewControllerActivityModePush,
    BMFPresentViewControllerActivityModeModal
} BMFPresentViewControllerActivityMode;

@interface BMFPresentViewControllerActivity : BMFActivity

/// BMFPresentViewControllerActivityModeSegue by default. For BMFPresentViewControllerActivityModeSegue value should contain the segue id. For BMFPresentViewControllerActivityModePush and BMFPresentViewControllerActivityModeModal it should be the view controller to present
@property (nonatomic, assign) BMFPresentViewControllerActivityMode mode;

/// YES by default
@property (nonatomic, assign) BOOL animated;

@end
