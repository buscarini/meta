//
//  TNStringLoader.h
//  DataSources
//
//  Created by José Manuel Sánchez on 23/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFLoaderProtocol.h"

@interface BMFStringLoader : NSObject <BMFLoaderProtocol>

@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, copy) NSString *string;

@end
