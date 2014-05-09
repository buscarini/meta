//
//  BMFSocialAccountAccessRequestOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSocialAccountAccessRequestOperation.h"

#import "BMF.h"

//#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface BMFSocialAccountAccessRequestOperation ()

@property (nonatomic, strong) NSString *accountTypeId;
@property (nonatomic, assign) BOOL cancelled;

@end

@implementation BMFSocialAccountAccessRequestOperation

- (instancetype) initWithAccountTypeIdentifier:(NSString *) accountTypeId {
	
	BMFAssertReturnNil(accountTypeId.length>0);
	
    self = [super init];
    if (self) {
        self.accountTypeId = accountTypeId;
    }
    return self;
}

- (id)init {
	[NSException raise:BMFLocalized(@"accountTypeId required. Use initWithAccountTypeIdentifier instead",nil) format:@""];
    return nil;
}

- (void) performStart {
	
	self.cancelled = NO;
	
	self.progress.progressMessage = BMFLocalized(@"Requesting account access", nil);

	ACAccountStore *account = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:self.accountTypeId];

	[account requestAccessToAccountsWithType:accountType
									 options:nil
								  completion:^(BOOL granted, NSError *error) {
									  
									  if (self.cancelled) {
										  [self finished];
										  return;
									  }
									  
									  NSArray *accounts = nil;
									  if (granted) {
										  accounts = [account accountsWithAccountType:accountType];
									  }
									  self.output = accounts;
									  self.progress.failedError = error;
									  [self finished];
								  }];
}

- (void) performCancel {
	self.cancelled = YES;
	self.progress.failedError = [NSError errorWithDomain:@"Social Account" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Cancelled",nil) }];
}


@end
