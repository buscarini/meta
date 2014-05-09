//
//  TNMapDataStore.h
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataSourceProtocol.h"

#import <MapKit/MapKit.h>

@interface BMFMapViewDataSource : NSObject <BMFDataSourceProtocol>

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

@property (nonatomic, strong) id<BMFDataReadProtocol> dataStore;
@property (nonatomic, strong) id<BMFDataReadProtocol> overlaysDataStore;
@property (nonatomic, weak) MKMapView *mapView;

- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>) dataStore;

@end
