//
//  TNMapAnnotation.h
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@protocol BMFMapAnnotation <MKAnnotation>

- (NSString *) annotationID;
- (BOOL) canShowCallout;

@optional

/// May be nil
- (UIImage *) annotationImage;

- (MKPinAnnotationColor) pinColor;

@end
