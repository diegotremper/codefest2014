//
//  HCPASecondViewController.m
//  HCPA
//
//  Created by Diego Tremper on 23/08/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPASecondViewController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

@interface HCPASecondViewController ()

@property (weak, nonatomic) IBOutlet UITabBarItem *requestItem;
@property (weak, nonatomic) IBOutlet UITextField *specialyText;
@property (weak, nonatomic) IBOutlet UITextView *obsText;

@end

@implementation HCPASecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _specialyText.text = self.q;
    
    _obsText.delegate = self;
    //Here I add a UITextView in code, it will work if it's added in IB too
    //To make the border look very close to a UITextField
    [_obsText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
    [_obsText.layer setBorderWidth:1.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    _obsText.layer.cornerRadius = 5;
    _obsText.clipsToBounds = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self edtitionStart: nil];
    return TRUE;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self editionEnd: nil];
    [self hideKeyboard: nil];
    return TRUE;
}

- (IBAction)edtitionStart:(id)sender {
    
    CGRect textFieldRect = [self.view.window convertRect:_obsText.bounds fromView:_obsText];
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
- (IBAction)editionEnd:(id)sender {
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (IBAction)hideKeyboard:(id)sender {
    [_specialyText setUserInteractionEnabled:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
