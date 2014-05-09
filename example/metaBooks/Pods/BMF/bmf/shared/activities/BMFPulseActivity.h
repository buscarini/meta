//
//  BMFPulseActivity.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFActivity.h"

#import "BMFTypes.h"

@class BMFEvent;

/// An activity that is enabled with an event, and it calls another activity when it receives another event
@interface BMFPulseActivity : BMFActivity

/// Every time it receives this event the pulse activity will be enabled, and disabled after calling the value activity
@property (nonatomic, strong) BMFEvent *enableEvent;

/// If it receives this event and it's enabled it will run the value activity
@property (nonatomic, strong) BMFEvent *runEvent;

/// The value should be the activity to call
@property (nonatomic, strong) BMFActivity *value;

/// The completion block to be run by the value activity when finished
@property (nonatomic, copy) BMFCompletionBlock completionBlock;

- (instancetype) initWithEnable:(BMFEvent *) enableEvent run:(BMFEvent *) runEvent value:(BMFActivity *)value;

@end
