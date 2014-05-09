//
//  TNFileLoader.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFLoaderProtocol.h"

@interface BMFFileLoader : NSObject <BMFLoaderProtocol>

@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, strong) NSURL *fileUrl;

@end
