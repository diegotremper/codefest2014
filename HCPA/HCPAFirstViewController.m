//
//  HCPAFirstViewController.m
//  SK2
//
//  Created by Diego Tremper on 20/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPAFirstViewController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

@interface HCPAFirstViewController ()

@end

@implementation HCPAFirstViewController

@synthesize geocoder = _geocoder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if ([self.textFieldSearch.text isEqualToString:@""]) {
        self.textFieldSearch.placeholder = @"Specialy you looking for";
    }
    
    if ([self.textFieldLocation.text isEqualToString:@""]) {
        self.textFieldLocation.placeholder = @"Location (Optional)";
    }
    
    [self.textFieldLocation resignFirstResponder];
    [self.textFieldSearch resignFirstResponder];
    
    [self.textFieldLocation setRightViewMode:UITextFieldViewModeAlways];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location.png"]];
    self.textFieldLocation.rightView= imageView;
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabLocationFinder)];
    
    imageView.frame = CGRectMake(0, 0, 25, 20);
    
    [imageView addGestureRecognizer:newTap];
}

-(void)tabLocationFinder{
    self.textFieldLocation.placeholder = @"Loading location ...";
    [self.textFieldLocation setText:@""];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setLocation) userInfo:nil repeats:NO];
}

-(void)setLocation{
    [self.textFieldLocation setText:@"Roseland, NJ"];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"Search";
    [self.textFieldLocation resignFirstResponder];
    [self.textFieldSearch resignFirstResponder];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.textFieldSearch setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchSegue"]) {
        HCPAListTableViewController *controller = (HCPAListTableViewController *)segue.destinationViewController;
        controller.q = self.textFieldSearch.text;
        controller.location = self.textFieldLocation.text;
    }
}

- (IBAction)searchRecomendations:(id)sender {
    [self.textFieldLocation resignFirstResponder];
    [self.textFieldSearch resignFirstResponder];
        // self.navigationController.navigationBarHidden = NO;
}

- (IBAction)searchEditingStart:(id)sender {
    if ([self.textFieldSearch.text isEqualToString:@""]) {
        self.textFieldSearch.placeholder = @"";
    }
    
    if ([self.textFieldLocation.text isEqualToString:@""]) {
        self.textFieldLocation.placeholder = @"";
    }
}

- (IBAction)searchEditingEnd:(id)sender {
    if ([self.textFieldSearch.text isEqualToString:@""]) {
        self.textFieldSearch.placeholder = @"Specialy you looking for";
    }
    
    if ([self.textFieldLocation.text isEqualToString:@""]) {
        self.textFieldLocation.placeholder = @"Location (Optional)";
    }
}

- (IBAction)locationEdtitionStart:(id)sender {
    
    CGRect textFieldRect = [self.view.window convertRect:self.textFieldLocation.bounds fromView:self.textFieldLocation];
    CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    } else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}
- (IBAction)locationEditionEnd:(id)sender {

    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
@end
