//
//  AppDelegate.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AppDelegate.h"

#import "GeTuiManager.h"

#import "TabBarViewController.h"

#import "LogViewController.h"

#import "GeTuiManager.h"

#import "SKShare.h"

#import "BootPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [SKShare initSDK];
    
    [GeTuiManager shareInstance];
    if(launchOptions != nil){
        
        [[GeTuiManager shareInstance] didFinishLaunchingWithOptions:launchOptions];
    }
    
    //iOS显示启动页时隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [NetWorkManager netWorkMonitoring];
    
    
    
    if([UserManager isLogin]){
     
        [self initTabVC];
    }
    else {
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"firststart"] == NO){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firststart"];
            
            BootPageViewController * bootVC = [[BootPageViewController alloc]init];
            bootVC.goBlock = ^{
                [self initLogVC];
            };
            self.window.rootViewController = bootVC;
            
        }
        else {
            
            [self initLogVC];
        }
    }
    
    [self regNotifiation];
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
        
    }
    
    
    application.applicationIconBadgeNumber = 0;
    
    
    return YES;
}



- (void)regNotifiation {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initLogVC) name:@"quitnotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initTabVC) name:@"lognotification" object:nil];
    
}



- (void)initLogVC {
    
    LogViewController *rootVC = [[LogViewController alloc]init];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:rootVC];
    
    self.window.rootViewController = navi;
}


- (void)initTabVC {
    
    TabBarViewController *rootVC = [[TabBarViewController alloc]init];
    
    self.window.rootViewController = rootVC;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





#pragma mark - 开始竖屏
//开启竖屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return (UIInterfaceOrientationMaskPortrait);
}



#pragma mark - app 回调
// 其他应用 回调

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    [SKShare handleOpenURL:url];
    
    return YES;
}


// 打开其他应用 或者链接 9.0 以后

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    [SKShare handleOpenURL:url];
    return YES;
}

// 4.2 - 9.0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [SKShare handleOpenURL:url];
    return YES;
}



// 推送部分


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error  {
    
    NSLog(@"didFailToRegistererror %@",error);
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[GeTuiManager shareInstance] registerForRemoteNotificationsWithDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"didReceiveRemoteNotification %@",userInfo);
    
    [[GeTuiManager shareInstance] didReceiveRemoteNotification:userInfo];
    
}



@end
