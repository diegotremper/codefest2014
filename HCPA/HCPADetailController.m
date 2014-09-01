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
@synthesize segmentControlView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]
    } forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]
                                                               } forState:UIControlStateSelected];
    tableViewController.scrollEnabled = NO;
    tableViewController.delegate = self;
    self.scrollView.delegate = self;
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

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"scrollViewDidScroll.Position: %g", scrollView.contentOffset.y);
    
    if (tableViewController.scrollEnabled == NO) {
        if (scrollView.contentOffset.y >= 128) {
            self.scrollView.scrollEnabled = NO;
            tableViewController.scrollEnabled = YES;
            scrollView.contentOffset = CGPointMake(0,128);
        }
    } else {
        if (scrollView.contentOffset.y < 0) {
            self.scrollView.scrollEnabled = YES;
            tableViewController.scrollEnabled = NO;
            // scrollView.contentOffset = CGPointMake(0,128);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging: %g", scrollView.contentOffset.y);
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDecelerating: %g", scrollView.contentOffset.y);
    
}
- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //NSArray* reviews = [self.placeDetail objectForKey:@"reviews"];
    //return reviews.count;
    NSLog(@"Teste");
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellReview";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"cellForRowAtIndexPath called");
    cell.textLabel.text = @"Teste";
    
    return cell;
}

@end
