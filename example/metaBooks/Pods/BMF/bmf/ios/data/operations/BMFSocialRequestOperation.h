//
//  BMFSocialRequestOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

#import <Social/Social.h>

@interface BMFSocialRequest : NSObject

@property (nonatomic, strong) ACAccount *account;
@property (nonatomic, strong) NSString *serviceType;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) SLRequestMethod method;
@property (nonatomic, strong) NSDictionary *parameters;

@end

@interface BMFSocialRequestOperation : BMFAsyncOperation

@property (nonatomic, strong) BMFProgress *progress;

- (instancetype) initWithRequest:(BMFSocialRequest *) request;

@end
