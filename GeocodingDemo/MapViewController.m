//
//  MapViewController.m
//  GeocodingDemo
//
//  Created by koogawa on 2012/10/04.
//  Copyright (c) 2012年 koogawa. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 地図配置
	CGRect mapFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	mapView_ = [[MKMapView alloc] initWithFrame:mapFrame];
    mapView_.showsUserLocation = YES;
	mapView_.delegate = self;
	mapView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:mapView_];
    
    // 位置調整
    MKCoordinateRegion region;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    region.center.latitude = 35.702065;
    region.center.longitude = 139.775308;
    [mapView_ setRegion:region animated:YES];
    
    UIBarButtonItem *currentButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:100
												  target:self
												  action:@selector(currentButtonAction)];
	
	// ツールバーにボタンを追加
	self.navigationItem.rightBarButtonItem = currentButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)currentButtonAction
{
    NSLog(@"%f, %f", mapView_.region.center.latitude, mapView_.region.center.longitude);
    
    // インスタンスの生成
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    // 逆ジオコーディングの開始
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mapView_.region.center.latitude
                                                      longitude:mapView_.region.center.longitude];
    
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
        if (error)
        {
            // エラーが発生している
            NSLog(@"error = %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                            message:@"ジオコーディングに失敗しました"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Close"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            NSLog(@"placemarks = %@", placemarks);
            
            if (0 < [placemarks count])
            {
                // 結果はひとつしかない
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:[placemark description]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"%f, %f", mapView.region.center.latitude, mapView.region.center.longitude];
}

@end
