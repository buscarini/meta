//
//  BMFEventProtocol.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import <Foundation/Foundation.h>
#import "BMFTypes.h"

@protocol BMFEventProtocol <NSObject>

@property (nonatomic, copy) BMFActionBlock eventBlock;

@end
