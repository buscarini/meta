//
//  TRNViewController.h
//  metaBooks
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "BMFTableViewController.h"

#import <BMF/BMFObjectDataStore.h>
#import <BMF/BMFObjectControllerProtocol.h>

@interface TRNBookListViewController : BMFTableViewController <BMFObjectControllerProtocol>

@property (nonatomic, strong) BMFObjectDataStore *objectStore;

@end
