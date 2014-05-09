//
//  BMFActionSheet.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActionSheet.h"

#import "BMF.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACDelegateProxy.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFActionSheet()

@property (nonatomic, strong) NSMutableArray *BMF_buttonsArray;
@property (nonatomic, strong) RACDelegateProxy *BMF_delegate;

@end

@implementation BMFActionSheet

- (instancetype) initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	BMFInvalidInit(initWithTitle:);
}

- (instancetype) initWithTitle:(NSString *)title {
	self = [super initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	if (self) {
		
		self.BMF_delegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UIActionSheetDelegate)];
		[[[self.BMF_delegate rac_signalForSelector:@selector(actionSheet:clickedButtonAtIndex:) fromProtocol:@protocol(UIActionSheetDelegate)] reduceEach:^id(UIActionSheet *actionSheet, NSNumber *buttonIndex){
			return buttonIndex;
		}] subscribeNext:^(NSNumber *buttonIndex) {
			BMFActionBlock block = self.BMF_buttonsArray[buttonIndex.integerValue];
			if (block) block(self);
		}];
		
		self.delegate = (id)self.BMF_delegate;
		
	}
	return self;
}


- (void) BMF_addButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block {
	[self BMF_createButtonsArray];
	
	NSInteger buttonIndex = [self addButtonWithTitle:title];
	
	if (block)	self.BMF_buttonsArray[buttonIndex] = [block copy];
	else self.BMF_buttonsArray[buttonIndex] = [NSNull null];
}

- (void) BMF_addCancelButtonWithActionBlock:(BMFActionBlock)block {
	[self BMF_addCancelButtonWithTitle:BMFLocalized(@"Cancel", nil) actionBlock:block];
}

- (void) BMF_addCancelButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block {
	[self BMF_createButtonsArray];
	
	self.cancelButtonIndex = [self addButtonWithTitle:title];
	
	if (block)	self.BMF_buttonsArray[self.cancelButtonIndex] = [block copy];
	else self.BMF_buttonsArray[self.cancelButtonIndex] = [NSNull null];
}

- (void) BMF_addDestructiveButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block {
	[self BMF_createButtonsArray];
	
	self.destructiveButtonIndex = [self addButtonWithTitle:title];
	if (block)	self.BMF_buttonsArray[self.destructiveButtonIndex] = [block copy];
	else self.BMF_buttonsArray[self.destructiveButtonIndex] = [NSNull null];
}

- (void) BMF_createButtonsArray {
	if (!self.BMF_buttonsArray) self.BMF_buttonsArray = [NSMutableArray array];
}

@end
