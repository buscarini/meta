//
//  BMFStringSerializer.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFSerializerProtocol.h"

@interface BMFStringSerializer : NSObject <BMFSerializerProtocol>

@property (nonatomic, assign) NSStringEncoding encoding;

@property (nonatomic, strong) BMFProgress *progress;

@end
