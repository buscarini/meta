//
//  BMFSocialRequestOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSocialRequestOperation.h"

#import "BMF.h"

@interface BMFSocialRequestOperation()

@property (nonatomic, strong) BMFSocialRequest *request;
@property (nonatomic, assign) BOOL cancelled;

@end

@implementation BMFSocialRequest
@end

@implementation BMFSocialRequestOperation

- (instancetype) initWithRequest:(BMFSocialRequest *) request {
	BMFAssertReturnNil(request);
	
    self = [super init];
    if (self) {
        self.request = request;
		self.progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (id)init {
	[NSException raise:BMFLocalized(@"request required. Use initWithRequest instead",nil) format:@""];
    return nil;
}

- (void) performStart {
	
	self.cancelled = NO;
	
	self.progress.progressMessage = BMFLocalized(@"Performing social request", nil);

	SLRequest *request = [SLRequest requestForServiceType:self.request.serviceType requestMethod:self.request.method URL:self.request.url parameters:self.request.parameters];
	request.account = self.request.account;
	[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		
		if (self.cancelled) {
			[self finished];
			return;
		}
		
		self.output = responseData;
		self.progress.failedError = error;
		[self finished];
	}];
	
	
}

- (void) performCancel {
	self.cancelled = YES;
	self.progress.failedError = [NSError errorWithDomain:@"Social Request" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Cancelled",nil) }];
}


@end
