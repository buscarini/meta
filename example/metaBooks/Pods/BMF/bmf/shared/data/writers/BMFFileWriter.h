//
//  TNFileWriter.h
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFWriterProtocol.h"

@interface BMFFileWriter : NSObject <BMFWriterProtocol>

@property (nonatomic, assign) NSDataWritingOptions options;

@property (nonatomic, strong) NSURL *fileUrl;

@end
