//
//  TNParserProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFLoaderProtocol.h"
#import "BMFProgress.h"

@protocol BMFParserProtocol <NSObject>

@property (nonatomic, strong) BMFProgress *progress;

- (void) parse:(id) rawObject completion:(BMFCompletionBlock) completionBlock;
- (void) cancel;

@end
