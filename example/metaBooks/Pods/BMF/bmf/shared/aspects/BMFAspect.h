//
//  BMFAspect.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/04/14.
//
//

#import <Foundation/Foundation.h>

#import "BMFAspectProtocol.h"

@interface BMFAspect : NSObject <BMFAspectProtocol>

@property (nonatomic, weak) id object;

@end
