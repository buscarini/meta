//
//  BMFConfigurationProtocol.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMFConfigurationProtocol <NSObject>

- (BOOL) setup;
- (void) tearDown;

@end
