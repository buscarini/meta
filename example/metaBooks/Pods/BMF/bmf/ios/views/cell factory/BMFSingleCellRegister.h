//
//  TNSingleCellRegister.h
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFCellRegister.h"

@interface BMFSingleCellRegister : BMFCellRegister

- (instancetype) initWithId:(NSString *) cellId classOrUINib:(id)classOrUINib;

@end
