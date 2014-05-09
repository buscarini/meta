//
//  BMFWebViewLoadOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

@interface BMFWebViewLoadResult : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *htmlString;

@end


@interface BMFWebViewLoadOperation : BMFAsyncOperation

@end
