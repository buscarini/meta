//
//  TNSingleCellRegister.m
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFSingleCellRegister.h"

#import "BMF.h"

#import <objc/runtime.h>

@interface BMFSingleCellRegister()

@property (nonatomic, strong) NSString *cellId;

@property (nonatomic, strong) id classOrUINib;

@end

@implementation BMFSingleCellRegister

- (NSString *) cellIdentifierForItem:(id)item atIndexPath:(NSIndexPath *)indexPath {
	return self.cellId;
}

- (instancetype) initWithId:(NSString *) cellId classOrUINib:(id)classOrUINib {
	BMFAssertReturnNil(cellId);
	
    self = [super init];
    if (self) {
        _cellId = cellId;
		_classOrUINib = classOrUINib;
    }
    return self;
}

- (void) registerTableCells: (UITableView *) tableView {
	if ([self.classOrUINib isKindOfClass:[UINib class]]) {
		[tableView registerNib:self.classOrUINib forCellReuseIdentifier:self.cellId];
	}
	else if (class_isMetaClass(object_getClass(self.classOrUINib))) {
		[tableView registerClass:self.classOrUINib forCellReuseIdentifier:self.cellId];
	}
}

- (void) registerCollectionCells:(UICollectionView *) collectionView {
	if ([self.classOrUINib isKindOfClass:[UINib class]]) {
		[collectionView registerNib:self.classOrUINib forCellWithReuseIdentifier:self.cellId];
	}
	else if (class_isMetaClass(object_getClass(self.classOrUINib))) {
		[collectionView registerClass:self.classOrUINib forCellWithReuseIdentifier:self.cellId];
	}
}


@end
