//
//  BMFImageSerializer.h
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFSerializerProtocol.h"
#import "BMFNode.h"

enum BMFImageSerializerWriteFormat {
	BMFImageSerializerFormatPNG,
	BMFImageSerializerFormatJPEG
	};

@interface BMFImageSerializer : NSObject <BMFSerializerProtocol>

@property (nonatomic, strong) NSMutableArray *nextNodes;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, assign) enum BMFImageSerializerWriteFormat writeFormat;

@property (nonatomic, strong) BMFProgress *progress;

/// Only applies with JPEG format
@property (nonatomic, assign) CGFloat compressionQuality;

@end
