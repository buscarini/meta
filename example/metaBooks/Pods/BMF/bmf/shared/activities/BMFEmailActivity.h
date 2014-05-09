//
//  BMFEmailActivity.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActivity.h"

@interface BMFEmailActivity : BMFActivity

@property (nonatomic, strong) NSArray *cc;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;

/// By default false, so it will show a MFMessageViewController. If set to true it will open the external mail app
@property (nonatomic, assign) BOOL openExternalApp;

@end
