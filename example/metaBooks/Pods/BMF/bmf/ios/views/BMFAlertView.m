//
//  BMFAlertView.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAlertView.h"

#import "BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACDelegateProxy.h>

@interface BMFAlertView()

@property (nonatomic, strong) NSMutableArray *BMF_buttonsArray;
@property (nonatomic, strong) RACDelegateProxy *BMF_delegate;

@end

@implementation BMFAlertView

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	BMFInvalidInit(initWithTitle:message:);
}

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message {
	self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	if (self) {
			
		self.BMF_delegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UIAlertViewDelegate)];
		[[[self.BMF_delegate rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] reduceEach:^id(UIAlertView *alertView, NSNumber *buttonIndex) {
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
	self.BMF_buttonsArray[buttonIndex] = [block copy];
}

- (void) BMF_addCancelButtonWithActionBlock:(BMFActionBlock)block {
	[self BMF_addCancelButtonWithTitle:BMFLocalized(@"Cancel", nil) actionBlock:block];
}

- (void) BMF_addCancelButtonWithTitle:(NSString *) title actionBlock:(BMFActionBlock)block {
	[self BMF_createButtonsArray];
	
	self.cancelButtonIndex = [self addButtonWithTitle:title];
	self.BMF_buttonsArray[self.cancelButtonIndex] = [block copy];
}

- (void) BMF_createButtonsArray {
	if (!self.BMF_buttonsArray) self.BMF_buttonsArray = [NSMutableArray array];
}


@end
