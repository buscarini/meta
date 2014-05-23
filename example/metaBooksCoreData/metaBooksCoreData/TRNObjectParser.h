//
//  TRNObjectParser.h
//  metaBooksCoreData
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TRNObjectParser <NSObject>

- (NSComparisonResult) compareDictionaries:(NSDictionary *) obj1 with:(NSDictionary *)obj2;
- (BOOL)updateObject:(id) object fromDictionary:(NSDictionary *)dictionary error:(NSError **) error;

@end
