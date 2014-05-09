//
//  BMFEvent.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFEventProtocol.h"

@interface BMFEvent : NSObject <BMFEventProtocol>

/// Called when the event occurs
@property (nonatomic, copy) BMFActionBlock eventBlock;

@end