//
//  TabBarViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TabBarViewController.h"


#import "HomeViewController.h"
#import "SignViewController.h"
#import "RemandViewController.h"
#import "InfoViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self creatVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)creatVCs {
    
    
    HomeViewController *vc1 = [[HomeViewController alloc]init];
    SignViewController *vc2 = [[SignViewController alloc]init];
    RemandViewController *vc3 = [[RemandViewController alloc]init];
    InfoViewController *vc4 = [[InfoViewController alloc]init];
    
    
    
    vc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[self imageOriginalWithName:@"tabbar_002"] selectedImage:[self imageOriginalWithName:@"tabbar_001"]];
    
    vc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"签到" image:[self imageOriginalWithName:@"tabbar_004"] selectedImage:[self imageOriginalWithName:@"tabbar_003"]];
    vc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"需求" image:[self imageOriginalWithName:@"tabbar_006"] selectedImage:[self imageOriginalWithName:@"tabbar_005"]];
    vc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[self imageOriginalWithName:@"tabbar_008"] selectedImage:[self imageOriginalWithName:@"tabbar_007"]];
    
    UIBaseNavigationController *navi1 = [[UIBaseNavigationController alloc]initWithRootViewController:vc1];
    UIBaseNavigationController *navi2 = [[UIBaseNavigationController alloc]initWithRootViewController:vc2];
    UIBaseNavigationController *navi3 = [[UIBaseNavigationController alloc]initWithRootViewController:vc3];
    UIBaseNavigationController *navi4 = [[UIBaseNavigationController alloc]initWithRootViewController:vc4];
    
    self.viewControllers = @[navi1,navi2,navi3,navi4];
    
    self.tabBar.translucent = NO;
    //    self.delegate = self;
    
    [[UITabBar appearance] setBackgroundColor:RGB(255, 255, 255)];
    [[UITabBar appearance] setTintColor:RGB(255, 255, 255)];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 50)];
    bgView.backgroundColor = RGB(255, 255, 255);
    [[UITabBar appearance] insertSubview:bgView atIndex:0];
    
    
    NSDictionary * attributes = @{NSForegroundColorAttributeName:RGB(100, 100, 100)};
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary * attributes2 = @{NSForegroundColorAttributeName:RGB(41, 181, 235)};
    [[UITabBarItem appearance] setTitleTextAttributes:attributes2 forState:UIControlStateSelected];
    
    [vc1.tabBarItem  setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [vc2.tabBarItem  setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [vc3.tabBarItem  setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [vc4.tabBarItem  setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
}



- (UIImage*)imageOriginalWithName:(NSString*)name {
    
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



@end
