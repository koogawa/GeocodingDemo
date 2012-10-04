//
//  MapViewController.h
//  GeocodingDemo
//
//  Created by koogawa on 2012/10/04.
//  Copyright (c) 2012年 koogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    MKMapView	*mapView_;
}

@end
