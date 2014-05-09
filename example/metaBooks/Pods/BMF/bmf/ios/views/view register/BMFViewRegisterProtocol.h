//
//  BMFViewRegisterProtocol.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFViewRegisterProtocol <NSObject>

- (NSString *) viewIdentifierForKind:(BMFViewKind) kind indexPath:(NSIndexPath *)indexPath;

- (id) classOrUINibForKind:(BMFViewKind) kind IndexPath:(NSIndexPath *) indexPath;

- (void) registerViews:(UIView *) view;


@end
