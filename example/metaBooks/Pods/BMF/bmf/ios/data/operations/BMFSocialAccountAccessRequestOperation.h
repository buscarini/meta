//
//  BMFSocialAccountAccessRequestOperation.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

@interface BMFSocialAccountAccessRequestOperation : BMFAsyncOperation

@property (nonatomic, strong) BMFProgress *progress;

- (instancetype) initWithAccountTypeIdentifier:(NSString *) accountTypeId;

@end
