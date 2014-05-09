//
//  BMFMapAnnotationFactory.m
//  DataSources
//
//  Created by José Manuel Sánchez on 29/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFMapAnnotationFactory.h"

@implementation BMFMapAnnotationFactory

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForUserAnnotation:(id<MKAnnotation>)annotation {
	return nil;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForMapAnnotation:(id<BMFMapAnnotation>)annotation {
	
	MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:annotation.annotationID];
	if (!view) {
		MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.annotationID];
		pinView.pinColor = annotation.pinColor;
		view = pinView;
	}
	
	view.canShowCallout = annotation.canShowCallout;
	if ([annotation respondsToSelector:@selector(annotationImage)]) view.image = annotation.annotationImage;
	
	return view;
}


@end
