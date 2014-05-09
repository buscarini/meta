//
//  NSString+BMFHTMLUtils.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

#define BMF_NSINTEGER_SIZE ((CHAR_BIT * sizeof(NSInteger) - 1) / 3 + 2)
#define BMF_FLOAT_SIZE ((CHAR_BIT * sizeof(CGFloat) - 1) / 3 + 2)

@interface NSString (BMF)

+ (NSString *) BMF_formatString:(NSString *) string;

+ (NSString *) BMF_stringWithFloat:(CGFloat) value;
+ (NSString *) BMF_stringWithInteger:(NSInteger) value;

- (NSString *) BMF_stringByEscapingForHTML;
- (NSString *) BMF_stringByEscapingForASCIIHTML;
- (NSString *) BMF_stringByUnescapingFromHTML;

- (CGRect) BMF_rectWithFont:(BMFIXFont *) font maxSize:(CGSize) maxSize;
- (CGRect) BMF_rectWithAttributes:(NSDictionary *) attributes maxSize:(CGSize) maxSize;

- (NSString *) BMF_unaccentedString;

@end
