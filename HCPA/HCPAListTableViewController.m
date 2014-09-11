//
//  HCPAListTableViewController.m
//  SK2
//
//  Created by Diego Tremper on 21/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPAListTableViewController.h"
#import "AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HCPAListTableViewController ()

@end

@implementation HCPAListTableViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, 100);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize: 14.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"Showing results for %@\n%@", self.q, self.location];
    self.navigationController.navigationBar.topItem.title = @"";
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
    
    self.placeAsArray = [[NSArray alloc] init];
    [self makePlacesRequests];

    if ([self.placeAsArray count] == 0) {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gotoAsk) userInfo:nil repeats:NO];
    }
}

-(void) gotoAsk {
    [self performSegueWithIdentifier:@"askSegue" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.placeAsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tempDictionary= [self.placeAsArray objectAtIndex:indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    UILabel *labelAddress = (UILabel *)[cell viewWithTag:4];
    UILabel *labelRatingsNbr = (UILabel *)[cell viewWithTag:5];
    UILabel *avgNbr = (UILabel *)[cell viewWithTag:6];
    
    [imageView setImage:[UIImage imageNamed:[tempDictionary objectForKey:@"gender"]]];
    label.text = [tempDictionary objectForKey:@"name"];
    labelAddress.text = [tempDictionary objectForKey:@"address"];
    labelRatingsNbr.text = [NSString stringWithFormat:@"(%@) Team (%@) Company (%@) Other", [tempDictionary objectForKey:@"review_team"], [tempDictionary objectForKey:@"review_company"], [tempDictionary objectForKey:@"review_other"]];
    avgNbr.text = [NSString stringWithFormat:@"%@ %%", [tempDictionary objectForKey:@"review_avg"]];
    
    return cell;
}

-(void)makePlacesRequests
{
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"search" ofType:@"json"];
     NSData* data = [NSData dataWithContentsOfFile:filePath];
     __autoreleasing NSError* error = nil;
     id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"keyword CONTAINS %@", self.q];
    
    self.placeAsArray = [[result objectForKey:@"results"] filteredArrayUsingPredicate:bPredicate];
    //self.placeAsArray = [result objectForKey:@"results"];
    [self.tableView reloadData];
    
    UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.view viewWithTag:12];
    [aiv stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailViewSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HCPADetailViewController *controller = (HCPADetailViewController *)segue.destinationViewController;
        controller.placeDetail = [self.placeAsArray objectAtIndex:indexPath.row];
    } else if ([segue.identifier isEqualToString:@"askSegue"]) {
        HCPASecondViewController *controller = (HCPASecondViewController *)segue.destinationViewController;
        controller.q = self.q;
        controller.countResults = [self.placeAsArray count];
    }
}

@end
