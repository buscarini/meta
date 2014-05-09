//
//  BMFStringSerializer.m
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFStringSerializer.h"

#import "BMF.h"

@implementation BMFStringSerializer

- (id)init
{
    self = [super init];
    if (self) {
        self.encoding = NSUTF8StringEncoding;
		self.progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (void) cancel {
	
}


- (void) parse:(NSData *) data completion:(BMFCompletionBlock)completionBlock {
	BMFAssertReturn(data);
	BMFAssertReturn(completionBlock);
	
//	if (!data || !completionBlock) {
//		[NSException raise:BMFLocalized(@"Data and completion block are mandatory for parsing and one of those is nil", nil) format:@""];
//		return;
//	}
	
	id output = [[NSString alloc] initWithData:data encoding:self.encoding];
	completionBlock(output,nil);
}

- (void) serialize:(id) object completion:(BMFCompletionBlock)completionBlock {
	BMFAssertReturn(object);
	BMFAssertReturn(completionBlock);
	
//	if (!object || !completionBlock) {
//		[NSException raise:BMFLocalized(@"Object and completion block are mandatory for parsing and one of those is nil", nil) format:@""];
//		return;
//	}
	
	if (![object isKindOfClass:[NSString class]]) {
		completionBlock(nil,[NSError errorWithDomain:BMFLocalized(@"Object is not a string", nil) code:BMFErrorInvalidType userInfo:object]);
	}
	else {
		NSString *string = object;
		completionBlock([string dataUsingEncoding:self.encoding],nil);
	}
}

@end
