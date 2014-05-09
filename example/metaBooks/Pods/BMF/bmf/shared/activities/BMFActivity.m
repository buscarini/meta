//
//  BMFActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivity.h"

@interface BMFActivity()

@property (nonatomic, assign) BOOL localizedValueChanged;

@end

@implementation BMFActivity

@synthesize localizedValue = _localizedValue;

- (BOOL) isAvailable {
	return YES;
}

- (void) setLocalizedValue:(NSString *)localizedValue {
	_localizedValue = localizedValue;
	self.localizedValueChanged = YES;
}

- (NSString *) localizedValue {
	if (self.localizedValueChanged) return _localizedValue;
	return self.value;
}

- (void) action:(id)input completion:(BMFCompletionBlock)completion {
	self.value = input;
	[self run:completion];
}

- (void) run: (BMFCompletionBlock) completionBlock {
	[NSException raise:@"Activity subclass didn't implement run: selector" format:@"%@",self];
}

@end
