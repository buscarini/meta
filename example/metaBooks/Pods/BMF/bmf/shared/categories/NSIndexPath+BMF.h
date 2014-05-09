//
//  NSIndexPath+BMF.h
//  BMFMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/03/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (BMF)

+ (NSIndexPath *) BMF_indexPathForRow:(NSInteger)row inSection:(NSInteger) section;

- (NSInteger) BMF_section;
- (NSInteger) BMF_row;

@end
