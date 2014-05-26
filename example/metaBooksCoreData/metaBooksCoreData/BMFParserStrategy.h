//
//  BMFParserStrategy.h
//  metaBooksCoreData
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BMF/BMFObjectParserProtocol.h>

@interface BMFParserStrategy : NSObject

@property (nonatomic, assign) NSUInteger batchSize;

- (NSArray *) parseDictionaries:(NSArray *) dictionaries localObjects:(NSArray *)localObjects objectParser:(id<BMFObjectParserProtocol>) objectParser;
	
@end
