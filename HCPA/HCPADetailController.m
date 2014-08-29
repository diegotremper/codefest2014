//
//  HCPADetailController.m
//  HCPA
//
//  Created by Diego Tremper on 24/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPADetailController.h"

@interface HCPADetailController ()

@end

@implementation HCPADetailController

//@synthesize locationView, reviewsView, segmentView;
//

- (void) changeSegment:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.placeNameLabel.text = [self.placeDetail objectForKey:@"name"];
    self.navigationItem.title = [self.placeDetail objectForKey:@"name"];
    
//    NSString *address = [self.placeDetail objectForKey:@"name"];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
//    MKCoordinateRegion thisRegion = {{0.0,0.0}, {0.0,0.0}};
//    
//    thisRegion.center.latitude = 22.569722;
//    thisRegion.center.longitude = 88.369722;
//    
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = 22.569722;
//    coordinate.longitude = 88.369722;
//    
//    thisRegion.center = coordinate;
//    
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.coordinate = coordinate;
//    annotation.title = address;
//
//    [self.mapView addAnnotation:annotation];
//    [self.mapView setRegion:thisRegion animated:YES];
//    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (IBAction)changeSegment:(UISegmentedControl *)sender {
//    
//    switch (sender.selectedSegmentIndex) {
//        case 0:
//            self.locationView.hidden = YES;
//            self.reviewsView.hidden = NO;
//            break;
//        
//        case 1:
//            self.locationView.hidden = NO;
//            self.reviewsView.hidden = YES;
//            
//        default:
//            break;
//    }
//}

@end
