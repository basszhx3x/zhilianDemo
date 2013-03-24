//
//  MapKitViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "myAnnotation.h"
#import "MapKitViewController.h"

@interface MapKitViewController ()

@end

@implementation MapKitViewController

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
    
//    if ([CLLocationManager locationServicesEnabled])
//    {
//        self.locManager=[[[CLLocationManager alloc]init]autorelease];
//        self.locManager.delegate=self;
//        // self.mapView.delegate=self;
//        //self.locManager.distanceFilter=10.0f;
//        //  self.locManager.desiredAccuracy=kCLLocationAccuracyBest;
//        [self.locManager startUpdatingLocation];
//    }
//
    
    self.mapView  = [[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    ;
    self.mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D centers ;
    MKCoordinateSpan spans;
    centers = CLLocationCoordinate2DMake(self.currentlongitude, self.currentlatitude);
    spans = MKCoordinateSpanMake(0.1, 0.1);
    //NSLog(@"%f",centers.latitude);
    MKCoordinateRegion regions = MKCoordinateRegionMake(centers, spans);
    self.mapView.region = regions;
    [self.view addSubview:self.mapView];
    
    myAnnotation *annota= [[myAnnotation alloc]init];
   // [annota setCoordinate:CLLocationCoordinate2DMake(self.currentlongitude, self.currentlatitude)];
    annota.coordinate = CLLocationCoordinate2DMake(self.currentlongitude, self.currentlatitude);
    [self.mapView addAnnotation:annota];
    [annota release];
        

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
