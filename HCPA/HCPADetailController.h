//
//  HCPADetailController.h
//  HCPA
//
//  Created by Diego Tremper on 24/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
//#import <CoreLocation/CoreLocation.h>

@interface HCPADetailController : UIViewController<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>
{
    __weak IBOutlet UITableView *tableViewController;
}

@property (strong, nonatomic) NSDictionary *placeDetail;
//@property (weak, nonatomic) IBOutlet UIView *locationView;
//@property (weak, nonatomic) IBOutlet UIView *reviewsView;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)changeSegment:(id)sender;

@end
