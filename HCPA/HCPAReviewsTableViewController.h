//
//  HCPAReviewsTableViewController.h
//  HCPA
//
//  Created by Diego Tremper on 29/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCPAReviewsTableViewController : UITableViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIView *viewOfSelf;
@property (strong, nonatomic) UIView *floatingView;
@property (strong, nonatomic) NSDictionary *placeDetail;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerRating;
@property (weak, nonatomic) IBOutlet UILabel *headerRatingCount;
@property (weak, nonatomic) IBOutlet UIImageView *headerFullImage;

@end
