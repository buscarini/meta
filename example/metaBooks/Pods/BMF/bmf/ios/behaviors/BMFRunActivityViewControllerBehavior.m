//
//  BMFPresentViewControllerBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFRunActivityViewControllerBehavior.h"

#import "BMFDetailViewControllerProtocol.h"

#import "BMFTableViewDataSource.h"

@implementation BMFRunActivityViewControllerBehavior

- (void) itemTapped:(id)item {
	id<BMFDetailViewControllerProtocol> vc = [self.activity.value BMF_castWithProtocol:@protocol(BMFDetailViewControllerProtocol)];
	
	vc.detailItem = item;
	
	[self.activity run:^(id result, NSError *error) {
		if (error) {
			DDLogError(@"Error presenting view controller: %@",error);
		}
	}];
}

@end
