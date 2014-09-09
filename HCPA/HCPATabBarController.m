//
//  HCPATabBarController.m
//  HCPA
//
//  Created by Diego Tremper on 08/09/14.
//  Copyright (c) 2014 Diego Tremper. All rights reserved.
//

#import "HCPATabBarController.h"

@interface HCPATabBarController ()

@end

@implementation HCPATabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    //self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    /*
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : appTintColor
                                                        } forState:UIControlStateSelected];
    
    */
    // doing this results in an easier to read unselected state then the default iOS 7 one
    //[[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
    //                                                    NSForegroundColorAttributeName : [UIColor whiteColor]
    //                                                    } forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
