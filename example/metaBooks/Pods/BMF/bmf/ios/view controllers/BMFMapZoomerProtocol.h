//
//  BMFMapZoomerProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 29/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKMapView;

@protocol BMFMapZoomerProtocol <NSObject>

@property (nonatomic, assign) BOOL includeOverlays;

/// Perform initial zoom to area of interest
- (void) didLoad:(MKMapView *) mapView;

/// Annotations loaded or modified
- (void) annotationsChanged:(MKMapView *) mapView;

/// Overlays loaded or modified
- (void) overlaysChanged:(MKMapView *) mapView;

/// User has tapped a button to show his current location
- (void) userLocationTapped:(MKMapView *) mapView;

/// User location has updated
- (void) userLocationChanged:(MKMapView *) mapView;


@end
