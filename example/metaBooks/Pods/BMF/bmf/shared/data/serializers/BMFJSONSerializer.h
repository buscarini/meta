//
//  BMFJSONSerializer.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFSerializerProtocol.h"

@interface BMFJSONSerializer : NSObject <BMFSerializerProtocol>

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

@property (nonatomic, strong) BMFProgress *progress;

@end
