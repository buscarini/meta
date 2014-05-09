//
//  NSData+BMF.h
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BMF)

- (NSData *) BMF_base64EncodedData;
- (NSData *) BMF_base64DecodedData;


@end
