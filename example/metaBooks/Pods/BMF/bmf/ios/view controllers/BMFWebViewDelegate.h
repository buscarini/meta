//
//  BMFWebViewDelegate.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMFWebViewDelegate <NSObject>

- (BOOL) openUrlExternally:(NSURL *) url navigationType:(UIWebViewNavigationType) navigationType;

@end
