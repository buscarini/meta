//
//  BMFFRDataStore.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFNode.h"
#import "BMFDataReadProtocol.h"

@class NSFetchRequest;

@interface BMFFRDataStore : BMFNode <BMFDataReadProtocol>

@property (nonatomic, strong) NSFetchRequest *fr;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, readonly) BOOL loaded;

@property (nonatomic, copy) NSString *sectionHeaderTitle;
@property (nonatomic, copy) NSString *sectionFooterTitle;

- (id)initWithFR:(NSFetchRequest *)fr context:(NSManagedObjectContext *) context;

- (BOOL) loadData:(BMFCompletionBlock) completionBlock;

@end
