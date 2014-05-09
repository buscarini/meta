//
//  BMFTimerEvent.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFEvent.h"

@interface BMFTimerEvent : BMFEvent

@property (nonatomic, assign) NSTimeInterval interval;

- (instancetype) initWithInterval:(NSTimeInterval) interval;

@end
