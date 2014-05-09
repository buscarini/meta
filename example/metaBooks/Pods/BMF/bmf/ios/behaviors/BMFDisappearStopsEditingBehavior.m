//
//  BMFDisappearStopsEditingBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDisappearStopsEditingBehavior.h"

@implementation BMFDisappearStopsEditingBehavior

- (void) viewWillDisappear:(BOOL)animated {
	[self.object.view endEditing:self.forceStopEditing];
}

@end
