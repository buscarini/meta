//
//  MKMapView+BMF.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "MKMapView+BMF.h"

@implementation MKMapView (BMF)

- (void) BMF_updateDelegate:(id)delegate {
	self.delegate = nil;
	self.delegate = delegate;
}

@end
