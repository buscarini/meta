//
//  BMFHTMLUtils.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFHTMLUtils : NSObject

/// Tries to find the title tag content
- (NSString *) findTitle:(NSString *) htmlString;

/// Tries to find an http-equiv="refresh" and returns the redirection url
- (NSString *) findRefresh:(NSString *) htmlString;

@end
