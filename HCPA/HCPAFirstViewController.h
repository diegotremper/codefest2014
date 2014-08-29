//
//  HCPAFirstViewController.h
//  SK2
//
//  Created by Diego Tremper on 20/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HCPAListTableViewController.h"

@interface HCPAFirstViewController : UIViewController {
    CGFloat animatedDistance;
}

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLocation;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageAdp;

- (IBAction)searchRecomendations:(id)sender;

@end
