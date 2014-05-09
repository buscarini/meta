//
//  BMFHTMLUtils.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFHTMLUtils.h"

#import "NSString+BMF.h"
#import "BMF.h"

@interface BMFHTMLUtils()

@property (nonatomic, strong) NSRegularExpression *titleRegEx;
@property (nonatomic, strong) NSRegularExpression *refreshRegEx;

@end

@implementation BMFHTMLUtils

- (instancetype)init
{
    self = [super init];
    if (self) {
		
		NSError *error = NULL;
		self.titleRegEx = [NSRegularExpression regularExpressionWithPattern:@"<title[^>]*>(.*?)</title>" options:NSRegularExpressionCaseInsensitive error:&error];
		self.refreshRegEx = [NSRegularExpression regularExpressionWithPattern:@"http-equiv.*?=.*?[\"']refresh[\"'][^>]*content=.*?URL=(.+?)[\"'].*?>" options:NSRegularExpressionCaseInsensitive error:&error];
    }
    return self;
}

- (NSString *) findTitle:(NSString *) htmlString {
	if (!htmlString) return nil;
	
	NSScanner *scanner = [NSScanner scannerWithString:htmlString];
	[scanner scanUpToString:@"<title>" intoString:nil];
	BOOL beginFound = [scanner scanString:@"<title>" intoString:nil];
	NSString *title = nil;
	[scanner scanUpToString:@"</title>" intoString:&title];
	
	if (title.length>0) return [title BMF_stringByUnescapingFromHTML];
	
	BOOL endFound = [scanner scanString:@"</title>" intoString:nil];
	
	if (beginFound && endFound) return nil;
	
	NSArray *matches = [self.titleRegEx matchesInString:htmlString options:0 range:NSMakeRange(0, htmlString.length)];
	NSTextCheckingResult *first = matches.firstObject;
	if (!first) return nil;
	if (first.numberOfRanges<=1) {
		return [[htmlString substringWithRange:first.range] BMF_stringByUnescapingFromHTML];
	}
	else {
		return [[htmlString substringWithRange:[first rangeAtIndex:1]] BMF_stringByUnescapingFromHTML];
	}
}

- (NSString *) findRefresh:(NSString *) htmlString {
	if (htmlString.length<15) return nil;
	
	NSScanner *scanner = [NSScanner scannerWithString:htmlString];
	NSRange range = NSMakeRange(0, htmlString.length);
	BOOL found = NO;
	while (!found) {
		NSRange foundRange = [htmlString rangeOfString:@"http-equiv" options:NSCaseInsensitiveSearch range:range];
		if (foundRange.location==NSNotFound) return NO;

		scanner.scanLocation = foundRange.location+foundRange.length;
		[scanner scanString:@"=" intoString:nil];
		[scanner scanString:@"\"" intoString:nil];
		[scanner scanString:@"'" intoString:nil];
		found = [scanner scanString:@"refresh" intoString:nil];
		if (!found) {
			NSUInteger oldLocation = range.location;
			range.location = foundRange.location+foundRange.length;
			range.length -= (range.location-oldLocation);
		}
		else {
			scanner.scanLocation = foundRange.location;
		}
	}

//	
//	
//	NSRange equivRange =[htmlString rangeOfString:@"http-equiv" options:NSCaseInsensitiveSearch];
//	if (equivRange.location==NSNotFound) return nil;
//	
//	NSScanner *scanner = [NSScanner scannerWithString:htmlString];
//	scanner.scanLocation = equivRange.location;
//	BOOL found = [scanner scanString:@"http-equiv=\"refresh\"" intoString:nil];
//	if (!found) {
//		NSRange equivRange =[htmlString rangeOfString:@"http-equiv" options:NSCaseInsensitiveSearch];
//		if (equivRange.location==NSNotFound) return nil;
//	}
	
	
	
	found = [scanner scanString:@"http-equiv=\"refresh\" content=\"0;URL=" intoString:nil];
	if (found) {
		NSString *urlString = nil;
		BOOL result = [scanner scanUpToString:@"\"" intoString:&urlString];
		if (result) return urlString;
	}
	
//	<META http-equiv="refresh" content="0;URL=http://twitter.com/mattgemmell/status/439170662012555264/photo/1">
	
	//DDLogInfo(@"refresh: %@",htmlString);
	
	NSArray *matches = [self.refreshRegEx matchesInString:htmlString options:0 range:NSMakeRange(range.location, htmlString.length-range.location)];
	
	for (NSTextCheckingResult *result in matches) {
		NSString *urlString = nil;
		if (result.numberOfRanges<=1) {
			urlString = [htmlString substringWithRange:result.range];
		}
		else {
			urlString = [htmlString substringWithRange:[result rangeAtIndex:1]];
		}
		if ([urlString rangeOfString:@"http"].location!=NSNotFound) return urlString;
	}
	
	return nil;
	
/*	NSTextCheckingResult *first = matches.firstObject;
	if (!first) return nil;
	if (first.numberOfRanges<=1) {
		return [htmlString substringWithRange:first.range];
	}
	else {
		
		NSString *urlString = [htmlString substringWithRange:[first rangeAtIndex:1]];
		
		return [htmlString substringWithRange:[first rangeAtIndex:1]];
	}*/
}


@end
