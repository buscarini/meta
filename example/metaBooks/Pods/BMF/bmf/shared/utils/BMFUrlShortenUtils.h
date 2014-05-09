//
//  BMFUrlShortenUtils.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"


@interface BMFUrlResult : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSData *data;

@end

@interface BMFUrlShortenUtils : NSObject

//+ (void) shorten:(NSURL *) url completion:(BMFCompletionBlock) completionBlock;

/// Recovers the canonical url and the data from a shortened or canonical url. Pass mime types to be filtered if you aren't interested in these types. If followRedirects is true it will check if the response contains a http-equiv="refresh" and it will load that url
- (void) recover:(NSURL *) url completion:(BMFCompletionBlock) completionBlock followRedirects:(BOOL)followRedirects acceptableContentTypes:(NSSet *) types;


@end
