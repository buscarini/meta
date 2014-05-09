//
//  BMFMagicalRecordConfigurationModule.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFConfigurationProtocol.h"

@interface BMFMagicalRecordConfigurationModule : NSObject <BMFConfigurationProtocol>

/// YES by default. This means it will save automatically when going to background and when terminating the app
@property (nonatomic, assign) BOOL automaticSaving;

@end
