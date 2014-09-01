//
//  HCPADetailViewController.m
//  HCPA
//
//  Created by Diego Tremper on 29/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPADetailViewController.h"

@interface HCPADetailViewController ()

@end

@implementation HCPADetailViewController

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
    self.navigationController.navigationBar.topItem.title = @"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueForReview"]) {
        HCPAReviewsTableViewController *controller = (HCPAReviewsTableViewController *)segue.destinationViewController;
        controller.placeDetail = self.placeDetail;
    }
}


@end
