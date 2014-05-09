//
//  TNCollectionViewDataSource.h
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataSource.h"
#import "BMFCellRegisterProtocol.h"
#import "BMFViewRegisterProtocol.h"

@interface BMFCollectionViewDataSource : BMFDataSource <UICollectionViewDataSource>

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) id<BMFCellRegisterProtocol> cellRegister;
@property (nonatomic, strong) id<BMFViewRegisterProtocol> supplementaryViewRegister;

@end
