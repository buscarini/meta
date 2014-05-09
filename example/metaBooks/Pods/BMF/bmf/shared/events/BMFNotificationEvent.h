//
//  BMFNotificationEvent.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFEvent.h"

@interface BMFNotificationEvent : BMFEvent

- (instancetype) initWithName:(NSString *)name;
- (instancetype) initWithName:(NSString *)name object:(id)object;

@end