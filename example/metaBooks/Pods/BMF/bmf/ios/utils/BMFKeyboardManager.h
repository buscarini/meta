//
//  BMFKeyboardManager.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 04/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFKeyboardManager : NSObject

@property (nonatomic, readonly) CGFloat keyboardHeight;
@property (nonatomic, readonly) double animationDuration;
@property (nonatomic, readonly) BOOL keyboardVisible;

@end
