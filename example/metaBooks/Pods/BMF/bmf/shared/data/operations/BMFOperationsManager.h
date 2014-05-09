//
//  BMFOperationsManager.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

// Tracks operations and allows to cancel all of them
@interface BMFOperationsManager : NSObject

- (void) addOperation: (NSOperation *) operation;

- (NSInteger) count;
- (BOOL) allFinished;
- (void) cancelAll;

@end
