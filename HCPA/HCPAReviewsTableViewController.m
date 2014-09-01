//
//  HCPAReviewsTableViewController.m
//  HCPA
//
//  Created by Diego Tremper on 29/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPAReviewsTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HCPAReviewsTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerTemplate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonReview;
@property (weak, nonatomic) IBOutlet UIButton *buttonLocation;

@end

@implementation HCPAReviewsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerLabel.text = [self.placeDetail objectForKey:@"name"];
    [self.headerRating setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"ratingw"]]
                    placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"ratingw_place_%@.png", [self.placeDetail objectForKey:@"id"]]]];
    
    self.headerRatingCount.text = [NSString stringWithFormat:@"%@ responses", [self.placeDetail objectForKey:@"rating_nbr"]];
    
    [self.headerFullImage setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"full_image"]]
              placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"full_image_%@.jpg", [self.placeDetail objectForKey:@"id"]]]];
    
    [self.headerImage setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"imagew"]]
              placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"imagew_place_%@.png", [self.placeDetail objectForKey:@"id"]]]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize: 14.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [self.placeDetail objectForKey:@"name"];
    [label sizeToFit];
    
    self.parentViewController.navigationItem.titleView = label;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y > 128) {
        
        if (self.floatingView == nil) {
            
            NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:_headerTemplate];
            self.floatingView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
            self.floatingView.hidden = NO;

            [self.view addSubview:self.floatingView];
            [self.view bringSubviewToFront:self.floatingView];
            
        }
        
        CGRect frame = self.floatingView.frame;
        frame.origin.y = scrollView.contentOffset.y - 128;
        self.floatingView.frame = frame;
        
    } else {
        for (UIView *subView in self.view.subviews) {
            if (subView == self.floatingView) {
                [subView removeFromSuperview];
                self.floatingView = nil;
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *reviewsAsArray = [self.placeDetail objectForKey:@"reviews"];
    
    return [reviewsAsArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReviewCell";
    NSLog(@"cellForRowAtIndexPath");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        if (self.viewOfSelf == nil) {
            NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:_headerTemplate];
            self.viewOfSelf = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
            self.viewOfSelf.hidden = NO;
        }
        
        UIImageView *hRating = (UIImageView *)[self.viewOfSelf viewWithTag:312];
        UIImageView *hFullImage = (UIImageView *)[self.viewOfSelf viewWithTag:20];
        UIImageView *hImage = (UIImageView *)[self.viewOfSelf viewWithTag:344];
        
        [hRating setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"ratingw"]]
                          placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"ratingw_place_%@.png", [self.placeDetail objectForKey:@"id"]]]];
        
        [hFullImage setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"full_image"]]
                             placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"full_image_%@.jpg", [self.placeDetail objectForKey:@"id"]]]];
        
        [hImage setImageWithURL:[NSURL URLWithString:[self.placeDetail objectForKey:@"imagew"]]
                         placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"imagew_place_%@.png", [self.placeDetail objectForKey:@"id"]]]];
        
        [cell addSubview:self.viewOfSelf];
    } else {
        NSArray *reviewsAsArray = [self.placeDetail objectForKey:@"reviews"];
        NSDictionary *tempDictionary= [reviewsAsArray objectAtIndex:indexPath.row - 1];
        UIImageView *avatarView = (UIImageView *)[cell viewWithTag:100];
        UIImageView *ratingView = (UIImageView *)[cell viewWithTag:400];
        UILabel *nameView = (UILabel *)[cell viewWithTag:101];
        UILabel *ocupationView = (UILabel *)[cell viewWithTag:102];
        UILabel *textView = (UILabel *)[cell viewWithTag:103];
        UILabel *agoView = (UILabel *)[cell viewWithTag:450];
        
        [avatarView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"avatar"]]
                  placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%@.png", [tempDictionary objectForKey:@"id"]]]];
        
        [ratingView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"p_rating"]]
                   placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"ratingid_%@.png", [tempDictionary objectForKey:@"id"]]]];
        
        nameView.text = [tempDictionary objectForKey:@"name"];
        ocupationView.text = [tempDictionary objectForKey:@"ocupation"];
        textView.text = [tempDictionary objectForKey:@"text"];
        agoView.text = [tempDictionary objectForKey:@"ago"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 168;
    } else {
        return 95;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
