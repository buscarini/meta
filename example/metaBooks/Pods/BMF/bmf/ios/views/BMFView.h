//
//  BMFView.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/12/13.
//  Copyright (c) 2013 José Manuel Sánchez. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface BMFView : UIView

#else

#import <AppKit/AppKit.h>

@interface BMFView : NSView

#endif

- (void) performInit;

@end
