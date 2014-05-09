//
//  TNAFNetworkingLoader.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFLoaderProtocol.h"

@interface BMFAFURLSessionLoader : NSObject <BMFLoaderProtocol>

@property (nonatomic, strong) NSURLSessionConfiguration *configuration;

@property (nonatomic, readonly) BMFProgress *progress;

@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, readonly) NSURL *finalUrl;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *userAgent;
@property (nonatomic, strong) NSSet *acceptableContentTypes;

@end
