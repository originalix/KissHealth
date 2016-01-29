//
//  BaseNavigationController.m
//  KissHealth
//
//  Created by Macx on 16/1/28.
//  Copyright © 2016年 LWHTteam. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //白色状态栏
    return UIStatusBarStyleLightContent;
}

@end
