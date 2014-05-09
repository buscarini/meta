//
//  MKMapView+BMF.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (BMF)

/// Useful if your delegate is a proxy and its respondToSelector results can vary
- (void) BMF_updateDelegate:(id)delegate;

@end
