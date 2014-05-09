//
//  TNLoaderProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFProgress.h"
#import "BMFTypes.h"

@protocol BMFLoaderProtocol <NSObject>

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, readonly) BMFProgress *progress;

/// Source can be a url, a file url, a string, etc
- (void) load:(BMFCompletionBlock) completionBlock;
- (void) cancel;

@end
