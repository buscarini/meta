//
//  BMFMapAnnotationFactoryProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 29/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFMapAnnotation.h"

@protocol BMFMapAnnotationFactoryProtocol <NSObject>

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForUserAnnotation:(id<MKAnnotation>)annotation;
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForMapAnnotation:(id<BMFMapAnnotation>)annotation;

@end
