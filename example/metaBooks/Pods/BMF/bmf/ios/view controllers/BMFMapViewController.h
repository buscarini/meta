//
//  TNMapViewController.h
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFViewController.h"

#import <MapKit/MapKit.h>
#import "BMFMapViewDataSource.h"
#import "BMFMapAnnotationFactoryProtocol.h"
#import "BMFMapZoomerProtocol.h"

#import "BMFArrayProxy.h"

@interface BMFMapViewController : BMFViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) id<BMFMapAnnotationFactoryProtocol> annotationFactory;
@property (nonatomic, strong) id<BMFMapZoomerProtocol> zoomer;

@property (nonatomic, strong) BMFMapViewDataSource *dataSource;

@property (nonatomic, copy) BMFActionBlock calloutButtonTapBlock;

@property (nonatomic, strong) BMFArrayProxy *mapDelegateProxy;

@end
