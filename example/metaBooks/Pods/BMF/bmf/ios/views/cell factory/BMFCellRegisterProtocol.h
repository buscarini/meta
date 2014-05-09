//
//  TNCellRegisterProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMFCellRegisterProtocol <NSObject>

- (NSString *) cellIdentifierForItem:(id)item atIndexPath:(NSIndexPath *) indexPath;
- (void) registerCells:(UIView *) view;

@end
