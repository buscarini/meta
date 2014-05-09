//
//  BMFPropertyCondition.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/04/14.
//
//

#import "BMFCondition.h"

@interface BMFPropertyCondition : BMFCondition

@property (nonatomic, weak) id object;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic, strong) id value;

- (instancetype) initWithObject:(id) object keyPath:(NSString *) keyPath value:(id)value;

@end
