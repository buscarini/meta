//
//  TNOperation.h
//  DataSources
//
//  Created by José Manuel Sánchez on 12/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFProgress.h"

@interface BMFOperation : NSOperation

@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, strong) id output;

- (void) clear;

@end
