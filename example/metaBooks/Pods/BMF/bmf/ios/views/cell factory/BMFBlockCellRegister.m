//
//  BMFBlockCellRegister.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBlockCellRegister.h"

#import "BMFTypes.h"

@interface BMFBlockCellRegister()

@property (nonatomic, copy) BMFCellRegisterCellsBlock registerBlock;
@property (nonatomic, copy) BMFCellIdBlock cellIdBlock;

@end

@implementation BMFBlockCellRegister

- (instancetype) initWithRegisterBlock:(BMFCellRegisterCellsBlock) registerBlock dequeueBlock:(BMFCellIdBlock)cellIdBlock {
	BMFAssertReturnNil(registerBlock);
	BMFAssertReturnNil(cellIdBlock);
	
    self = [super init];
    if (self) {
        self.registerBlock = registerBlock;
		self.cellIdBlock = cellIdBlock;
    }
    return self;
}

- (instancetype)init {
	[NSException raise:@"BMFBlockCellRegister requires register and dequeue blocks" format:@"Use initWithRegisterBlock:dequeueBlock: instead"];
    return nil;
}

#pragma mark BMFCellRegisterProtocol

- (NSString *) cellIdentifierForItem:(id)item atIndexPath:(NSIndexPath *)indexPath {
	return self.cellIdBlock(item,indexPath);
}

- (void) registerCells:(UIView *) view {
	self.registerBlock(view);
}


@end