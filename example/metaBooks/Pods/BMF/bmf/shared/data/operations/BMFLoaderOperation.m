//
//  TNLoaderOperation.m
//  DataSources
//
//  Created by José Manuel Sánchez on 13/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFLoaderOperation.h"

#import "BMF.h"

@interface BMFLoaderOperation()

@property (strong, nonatomic) id<BMFLoaderProtocol> loader;

@end

@implementation BMFLoaderOperation

- (instancetype) initWithLoader:(id<BMFLoaderProtocol>) loader {
	BMFAssertReturnNil(loader);
//	if (!loader) {
//		[NSException raise:BMFLocalized(@"loader required",nil) format:@""];
//		return nil;
//	}

    self = [super init];
    if (self) {
        self.loader = loader;
    }
    return self;
}
	
- (id)init {
	[NSException raise:BMFLocalized(@"loader required. Use initWithLoader instead",nil) format:@""];
    return nil;
}

- (BMFProgress *) progress {
	return self.loader.progress;
}


- (void) performStart {
	[self.loader load:^(id responseObject, NSError *error) {
		self.output = responseObject;
		[self finished];
	}];
}

- (void) performCancel {
	[self.loader cancel];
}

@end
