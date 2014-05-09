//
//  BMFFactoryProtocol.h
//  BMFMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMFTaskProtocol;

@protocol BMFNetworkFactoryProtocol <NSObject>

- (id) loaderWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;
- (id) loaderOperationWithUrlString:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;

- (id) fileLoaderOperationWithUrl:(NSURL *) fileURL sender:(id) sender;

- (id<BMFTaskProtocol>) dataLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;
- (id<BMFTaskProtocol>) imageLoadTask:(NSString *) urlString parameters:(NSDictionary *) parameters sender:(id) sender;


@end
