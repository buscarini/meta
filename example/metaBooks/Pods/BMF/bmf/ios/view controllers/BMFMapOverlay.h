//
//  BMFMapOverlay.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@protocol BMFMapOverlay <MKOverlay>

- (MKOverlayRenderer *) renderer;

@end
