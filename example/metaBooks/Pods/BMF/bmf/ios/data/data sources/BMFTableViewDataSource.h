//
//  TNTableDataSource.h
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataSource.h"

#import "BMFCellRegisterProtocol.h"
#import "BMFViewRegisterProtocol.h"


typedef void (^BMFTableViewCellConfigureBlock)(id cell, id item);

@interface BMFTableViewDataSource : BMFDataSource <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) id<BMFCellRegisterProtocol> cellRegister;
@property (nonatomic, strong) id<BMFViewRegisterProtocol> viewRegister;

/// Removed. Instead, make a subclass of BMFCellConfigurator and register it in the +(void)load method
//@property (nonatomic, copy) BMFTableViewCellConfigureBlock configureCellBlock;

/// Use animatedUpdates only if the change rate is slow
- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>)dataStore animatedUpdates:(BOOL) animatedUpdates;


@end
