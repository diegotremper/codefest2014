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
    label.text = [NSString stringWithFormat:@"%@\n%@", self.q, self.location];
    self.navigationController.navigationBar.topItem.title = @"";
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
    
    self.placeAsArray = [[NSArray alloc] init];
    [self makePlacesRequests];
    self.navigationController.navigationBarHidden = NO;
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
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
    UIImageView *imageRatingView = (UIImageView *)[cell viewWithTag:3];
    UILabel *labelAddress = (UILabel *)[cell viewWithTag:4];
    UILabel *labelRatingsNbr = (UILabel *)[cell viewWithTag:5];
    
    [imageView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"image"]]
                   placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"image_place_%@.png", [tempDictionary objectForKey:@"id"]]]];
    
    [imageRatingView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"rating"]]
              placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"rating_place_%@.png", [tempDictionary objectForKey:@"id"]]]];
    
    label.text = [tempDictionary objectForKey:@"name"];
    labelAddress.text = [tempDictionary objectForKey:@"address"];
    labelRatingsNbr.text = [NSString stringWithFormat:@"%@ responses", [tempDictionary objectForKey:@"rating_nbr"]];
    
    return cell;
}

-(void)makePlacesRequests
{
    NSURL *URL = [NSURL URLWithString:@"http://www.textualize.com.br/app/search.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.placeAsArray = [responseObject objectForKey:@"results"];
        [self.tableView reloadData];
        
        UIActivityIndicatorView *aiv = [self.view viewWithTag:12];
        [aiv stopAnimating];
        
    } failure:nil];
    [operation start];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailViewSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HCPADetailViewController *controller = (HCPADetailViewController *)segue.destinationViewController;
        controller.placeDetail = [self.placeAsArray objectAtIndex:indexPath.row];
    }
}

@end
