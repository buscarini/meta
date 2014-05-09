//
//  BMFViewRegisterData.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewRegisterInfo.h"

#import "BMFTypes.h"

@implementation BMFViewRegisterInfo

- (instancetype) initWithId:(NSString *) viewId kind:(BMFViewKind) kind classOrUINib:(id)classOrUINib {
	BMFAssertReturnNil(viewId);

	self = [super init];
	if (self) {
		_viewId = viewId;
		_kind = kind;
		_classOrUINib = classOrUINib;
	}
	return self;
}

- (instancetype) init {
	[NSException raise:@"Error. Viewid kind and classornib are required" format:@"Use initWithId:kind:classOrUINib instead"];
	return nil;
}


@end
