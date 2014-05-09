//
//  BMFSimpleViewRegister.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewRegister.h"
#import "BMFViewRegisterInfo.h"

@interface BMFSimpleViewRegister : BMFViewRegister

- (NSString *) viewIdentifierForKind:(BMFViewKind)kind indexPath:(NSIndexPath *) indexPath;
- (id) classOrUINibForKind:(BMFViewKind)kind indexPath:(NSIndexPath *) indexPath;

// infos is and array of BMFViewRegisterInfo
- (instancetype) initWithInfos:(NSArray *) infos;

@end
