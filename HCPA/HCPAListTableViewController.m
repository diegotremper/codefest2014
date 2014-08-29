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


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Called viewDidAppear");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Called numberOfSectionsInTableView");
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Called numberOfRowsInSection");
    // Return the number of rows in the section.
    return [self.placeAsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"Called callForRowAtIndexPath");
    NSDictionary *tempDictionary= [self.placeAsArray objectAtIndex:indexPath.row];
    
    UIImageView *imageView = [cell viewWithTag:1];
    UILabel *label = [cell viewWithTag:2];
    UIImageView *imageRatingView = [cell viewWithTag:3];
    
    //NSData *imageData = [NSData dataWithContentsOfURL:];
    //imageView.image = [UIImage imageWithData:imageData];
    
    [imageView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"image"]]
                   placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"image_place_%@.png", [tempDictionary objectForKey:@"id"]]]];
    
    [imageRatingView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"rating"]]
              placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"rating_place_%@.png", [tempDictionary objectForKey:@"id"]]]];
    
    //NSData *imageRatingData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[tempDictionary objectForKey:@"rating"]]];
    //imageRatingView.image = [UIImage imageWithData:imageRatingData];
    
    label.text = [tempDictionary objectForKey:@"name"];
    
    return cell;
}

-(void)makePlacesRequests
{
    NSURL *URL = [NSURL URLWithString:@"http://www.textualize.com.br/app/search.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        self.placeAsArray = [responseObject objectForKey:@"results"];
        [self.tableView reloadData];
        
        UIActivityIndicatorView *aiv = [self.view viewWithTag:12];
        [aiv stopAnimating];
        
        NSLog(@"Called reloadData");
    } failure:nil];
    [operation start];
    NSLog(@"Called makePlacesRequests");
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailViewSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HCPADetailController *controller = (HCPADetailController *)segue.destinationViewController;
        controller.placeDetail = [self.placeAsArray objectAtIndex:indexPath.row];
    }
}

@end
