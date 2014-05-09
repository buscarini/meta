//
//  TNSerializerProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"
#import "BMFProgress.h"

@protocol BMFSerializerProtocol <NSObject>

- (void) cancel;
- (void) parse:(NSData *) data completion:(BMFCompletionBlock)completionBlock;
- (void) serialize:(id) object completion:(BMFCompletionBlock)completionBlock;

@property (nonatomic, strong) BMFProgress *progress;

@end
