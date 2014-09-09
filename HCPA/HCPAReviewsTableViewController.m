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
    [self.headerImage setImage:[UIImage imageNamed:[self.placeDetail objectForKey:@"gender"]]];
    self.scoreText.text = [NSString stringWithFormat:@"%@ %%", [self.placeDetail objectForKey:@"review_avg"]];
    self.textOcupation.text = [self.placeDetail objectForKey:@"ocupation"];
    [self.buttonTeam setTitle: [NSString stringWithFormat:@"Team (%@)", [self.placeDetail objectForKey:@"review_team"]] forState:UIControlStateNormal];
    [self.buttonCompany setTitle: [NSString stringWithFormat:@"Company (%@)", [self.placeDetail objectForKey:@"review_company"]] forState:UIControlStateNormal];
    [self.buttonOther
     setTitle: [NSString stringWithFormat:@"Other (%@)", [self.placeDetail objectForKey:@"review_other"]] forState:UIControlStateNormal];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        if (self.viewOfSelf == nil) {
            NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:_headerTemplate];
            self.viewOfSelf = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
            self.viewOfSelf.hidden = NO;
        }
        
        UIImageView *hImage = (UIImageView *)[self.viewOfSelf viewWithTag:344];
        [hImage setImage:[UIImage imageNamed:[self.placeDetail objectForKey:@"gender"]]];
        UIImageView *ratingsView = nil;
        
        for (int i = 601; i < 606; i++) {
            ratingsView = (UIImageView *)[self.viewOfSelf viewWithTag:i];
            int rat = [[self.placeDetail objectForKey:@"promoters"] integerValue];
            int j = i - 600;
            if (rat >= j) {
                [ratingsView setImage: [UIImage imageNamed:@"promoter"]];
            } else {
                [ratingsView setImage:nil];
            }
        }
        
        for (int i = 701; i < 706; i++) {
            ratingsView = (UIImageView *)[self.viewOfSelf viewWithTag:i];
            int rat = [[self.placeDetail objectForKey:@"passives"] integerValue];
            int j = i - 700;
            if (rat >= j) {
                [ratingsView setImage: [UIImage imageNamed:@"passive"]];
            } else {
                [ratingsView setImage:nil];
            }
        }
        
        for (int i = 801; i < 806; i++) {
            ratingsView = (UIImageView *)[self.viewOfSelf viewWithTag:i];
            int rat = [[self.placeDetail objectForKey:@"detractors"] integerValue];
            int j = i - 800;
            if (rat >= j) {
                [ratingsView setImage: [UIImage imageNamed:@"detractor"]];
            } else {
                [ratingsView setImage:nil];
            }
        }
        
        [cell addSubview:self.viewOfSelf];
    } else {
        NSArray *reviewsAsArray = [self.placeDetail objectForKey:@"reviews"];
        NSDictionary *tempDictionary= [reviewsAsArray objectAtIndex:indexPath.row - 1];
        UIImageView *avatarView = (UIImageView *)[cell viewWithTag:100];
        UILabel *nameView = (UILabel *)[cell viewWithTag:101];
        UILabel *textView = (UILabel *)[cell viewWithTag:103];
        
        [avatarView setImage:[UIImage imageNamed:@"associate"]];
        nameView.text = [tempDictionary objectForKey:@"name"];
        textView.text = [tempDictionary objectForKey:@"text"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 168;
    } else {
        return 60;
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
