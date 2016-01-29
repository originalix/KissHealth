//
//  KHTabBarVC.m
//  KissHealth
//
//  Created by Macx on 16/1/27.
//  Copyright © 2016年 LWHTteam. All rights reserved.
//

#import "KHTabBarVC.h"
#import "BaseNavigationController.h"
#define kButtonTitleFont 13
#define kSpacing 5   //image 和 title的间距
#define kTopSpacing 3 //image 和tabBar的间距


@interface KHTabBarVC ()

@end

@implementation KHTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"nav_tabbar_background"]];
    [self _creatViewControllers];
}

- (void)_creatViewControllers
{
    NSArray *storyboardNames = @[@"Home",@"Diary",@"Progress",@"More"];
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i < storyboardNames.count; i++)
    {
        BaseNavigationController *navi = [[UIStoryboard storyboardWithName:storyboardNames[i] bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [controllers addObject:navi];
    }
    //留给何桂灿烂的第三个VC自己修改,这里是为了防止崩溃，按顺序添加的
    UIViewController *keepVC = [[UIViewController alloc] init];
    [controllers insertObject:keepVC atIndex:2];
    
    self.viewControllers = controllers;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self _removeSystemTabBarButtons];
    [self _creatMyButtons];
    
}

- (void)_removeSystemTabBarButtons
{
    Class cls = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.tabBar.subviews)
    {
        if ([view isKindOfClass:cls])
        {
            [view removeFromSuperview];
        }
    }
}


- (void)_creatMyButtons
{
    NSArray *imgNames = @[
                          @"ic_tabbar_home_normal.png",
                          @"ic_tabbar_diary_normal.png",
                          @"ic_tabbar_progress_normal.png",
                          @"ic_tabbar_more_normal.png",
                          ];
    NSArray *activeImgNames = @[
                                @"ic_tabbar_home_active.png",
                                @"ic_tabbar_diary_active.png",
                                @"ic_tabbar_progress_active.png",
                                @"ic_tabbar_more_active.png",
                                ];
    NSArray *titleNames = @[@"首页",
                            @"日记",
                            @"进度",
                            @"更多"
                            ];
    
    
    CGFloat buttonWidth = kScreenWidth / 5;
    CGFloat buttonHeight = self.tabBar.frame.size.height;
    
    for (int i = 0; i < 4; i ++)
    {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:activeImgNames[i]] forState:UIControlStateSelected];
        [self configButtonEdgeInsets:button Image:[UIImage imageNamed:imgNames[i]] Title:titleNames[i]];
        //启动程序保证首页button图片正确
        if (i == 0)
        {
            button.selected = YES;
        }
        if (i < 2)
        {
            button.frame=CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight);
            button.tag = 1000 + i;
        }
        else
        {
           button.frame=CGRectMake(buttonWidth*(i+1),0,buttonWidth,buttonHeight);
            button.tag = 1000 + i + 1;
        }
        [button addTarget:self action:@selector(selectVC:) forControlEvents:UIControlEventTouchUpInside];
        
       
        [self.tabBar addSubview:button];
    }
    
}

- (void)selectVC:(UIButton *)sender
{
    for (UIView *view in self.tabBar.subviews)
    {
        if ([view isMemberOfClass:[UIButton class]])
        {
            [(UIButton *)view setSelected:NO];
        }
    }
    sender.selected = YES;
    self.selectedIndex = sender.tag - 1000;
}

//对button进行设置，图片在上，文字在下
- (UIButton *)configButtonEdgeInsets:(UIButton *)button Image:(UIImage *)image Title:(NSString *)title
{
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFont];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    CGFloat labelWidth = [title
                          sizeWithAttributes:@{
                                               NSFontAttributeName:[UIFont systemFontOfSize:kButtonTitleFont],
                                               }].width;
    CGFloat labelHeight = [title
                           sizeWithAttributes:@{
                                                NSFontAttributeName:[UIFont systemFontOfSize:kButtonTitleFont],
                                                }].height;
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    //image中心移动的x距离
    CGFloat imageOfsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    //image中心移动的y距离
    CGFloat imageOfsetY = imageHeight / 2 + kSpacing / 2 - kTopSpacing;
    //label中心移动的x距离
    CGFloat labelOfsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    //label中心移动的y距离
    CGFloat labelOfsetY = labelHeight / 2 + kSpacing / 2 + kTopSpacing;
    
    button.imageEdgeInsets = UIEdgeInsetsMake(-imageOfsetY, imageOfsetX, imageOfsetY, -imageOfsetX);
    button.titleEdgeInsets = UIEdgeInsetsMake(labelOfsetY, -labelOfsetX, -labelOfsetY, labelOfsetX);

    
    return button;
}

@end
