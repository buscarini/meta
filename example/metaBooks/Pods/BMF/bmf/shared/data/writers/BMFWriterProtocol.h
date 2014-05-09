//
//  TNWriterProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"
#import "BMFProgress.h"

@protocol BMFWriterProtocol <NSObject>

@property (nonatomic, strong) BMFProgress *progress;

/// Destination can be a url, a file url, a string, etc
- (void) write:(NSData *)data completion:(BMFCompletionBlock) completionBlock;
- (void) cancel;

@end
