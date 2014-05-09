//
//  BMFSelectorEvent.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFEvent.h"

@interface BMFSelectorEvent : BMFEvent

- (instancetype) initWithObject:(id) object selector:(SEL) selector;

@end
