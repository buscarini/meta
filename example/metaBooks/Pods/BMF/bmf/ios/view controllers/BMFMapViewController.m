//
//  BMFMapViewController.m
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFMapViewController.h"

#import "BMFMapAnnotation.h"
#import "BMFMapOverlay.h"
#import "BMFMapZoomer.h"
#import "BMFMapAnnotationFactory.h"

#import "BMFDataReadProtocol.h"

#import "MKMapView+BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFMapViewController ()

@end

@implementation BMFMapViewController

- (void) performInit {
	[super performInit];
	
	// Add default components which can be changed later
	_zoomer = [BMFMapZoomer new];
	_annotationFactory = [BMFMapAnnotationFactory new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	@weakify(self);
	
	[[RACObserve(self, dataSource) scanWithStart:nil reduce:^id(id running, id next) {
		@strongify(self);
		[self.mapDelegateProxy removeDestinationObject:running];
		return next;
	}] subscribeNext:^(id x) {
		@strongify(self);
		[self.mapDelegateProxy addDestinationObject:x];

		self.dataSource.mapView = self.mapView;
		
		@weakify(self);
		self.dataSource.dataChangedBlock = ^(id result,NSError *error) {
			@strongify(self);
			if (!error) {
				[self.zoomer annotationsChanged:self.mapView];
			}
		};
	}];

	RACSignal *mapViewSignal = RACObserve(self, mapView);
	
	RAC(self.dataSource,mapView) = mapViewSignal;

	[mapViewSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.zoomer didLoad:self.mapView];
	}];
	

	self.mapDelegateProxy = [BMFArrayProxy new];
	
	[self.mapDelegateProxy.destinationsSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.mapView BMF_updateDelegate:self.mapDelegateProxy];

	}];
	
//	self.mapDelegateProxy.destinationsChangedBlock = ^(BMFArrayProxy *proxy) {
//		@strongify(self);
//		[self.mapView BMF_updateDelegate:proxy];
//	};
}

//- (void) setZoomer:(id<BMFMapZoomerProtocol>)zoomer {
//	_zoomer = zoomer;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) setMapView:(MKMapView *)mapView {
//	_mapView = mapView;
//	_dataSource.mapView = mapView;
//}

/*- (void) setDataSource:(BMFMapViewDataSource *)dataSource {
	_dataSource = dataSource;

	__weak BMFMapViewController *weakSelf = self;
	_dataSource.dataChangedBlock = ^(id result,NSError *error) {
		if (!error) {
			[weakSelf.zoomer annotationsChanged:weakSelf.mapView];
		}
	};
	
	_dataSource.mapView = self.mapView;
}*/

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation {
	
	id<BMFMapAnnotation> mapAnnotation = nil;
	
	if (annotation==mapView.userLocation) {
		return [self.annotationFactory mapView:mapView viewForUserAnnotation:annotation];
	}
	
	if ([annotation conformsToProtocol:@protocol(BMFMapAnnotation)]) {
		mapAnnotation = (id<BMFMapAnnotation>)annotation;
		return [self.annotationFactory mapView:mapView viewForMapAnnotation:mapAnnotation];
	}
	
	return nil;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
	
	if (![overlay conformsToProtocol:@protocol(BMFMapOverlay)]) {
		[NSException raise:@"Overlay doesn't conform to protocol BMFMapOverlay" format:@"%@",overlay];
		return nil;
	}
	
	id<BMFMapOverlay> mapOverlay = (id<BMFMapOverlay>)overlay;
	return [mapOverlay renderer];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
	[self.zoomer userLocationChanged:self.mapView];
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	if (self.calloutButtonTapBlock) self.calloutButtonTapBlock(view);
}

@end
