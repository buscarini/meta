//
//  BMFPasteboard.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFPasteboard : NSObject

+ (BOOL) setString:(NSString *) string;
+ (NSString *) string;

@end
