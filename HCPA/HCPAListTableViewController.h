//
//  HCPAListTableViewController.h
//  SK2
//
//  Created by Diego Tremper on 21/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCPADetailViewController.h"
#import "HCPASecondViewController.h"

@interface HCPAListTableViewController : UITableViewController

@property(nonatomic) NSString *q;
@property(nonatomic) NSString *location;
@property (strong, nonatomic) NSArray *placeAsArray;

@end
