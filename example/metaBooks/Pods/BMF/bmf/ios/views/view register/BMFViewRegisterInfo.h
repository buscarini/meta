//
//  BMFViewRegisterData.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFViewRegisterProtocol.h"

@interface BMFViewRegisterInfo : NSObject

@property (nonatomic, assign) BMFViewKind kind;
@property (nonatomic, strong) NSString *viewId;
@property (nonatomic, strong) id classOrUINib;

- (id) initWithId:(NSString *) viewId kind:(BMFViewKind) kind classOrUINib:(id)classOrUINib;

@end
