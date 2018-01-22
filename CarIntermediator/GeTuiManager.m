//
//  GeTuiManager.m
//  Aladdin
//
//  Created by yuyue on 2017/3/29.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "GeTuiManager.h"



#import <UserNotifications/UserNotifications.h>


@interface GeTuiManager ()<GeTuiSdkDelegate ,UNUserNotificationCenterDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)NSDictionary * userInfo;

@property (nonatomic,strong)UIAlertView *alert ;

@end

@implementation GeTuiManager


static GeTuiManager *geTuiManager = nil;

+ (GeTuiManager*)shareInstance {
    
    if(geTuiManager == nil){
        
        geTuiManager = [[GeTuiManager  alloc]init];
        [geTuiManager startSDK];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;
    
    return geTuiManager;
}




#define kGtAppId           @"4UmIrFY1hZ5GXiVDkyesg5"
#define kGtAppKey          @"basgDUfA4G7yYlTEwsFc77"
#define kGtAppSecret       @"LKbA6lAgpF9apNVVLWozn3"

//#define kGtAppId           @"NRHqx3VsV96JVJUxgu4GF6"
//#define kGtAppKey          @"AOMsHw5AVf63ZnP2z4gBV8"
//#define kGtAppSecret       @"zOqmCe6ghX7lBEeGy0ViX9"

- (void)startSDK {
    
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册APNS
    
//    [GeTuiSdk runBackgroundEnable:YES];
    
#pragma mark 推送管理
    [self setIsOpen:YES];
    
    [self registerUserNotification];
    
}



- (BOOL)isOpen {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"ManagerRemoteNotification"];
}


- (void)setIsOpen:(BOOL)isOpen {
    
    [[NSUserDefaults standardUserDefaults] setBool:isOpen forKey:@"ManagerRemoteNotification"];
    [GeTuiSdk runBackgroundEnable:isOpen];

}





/** 注册APNS */
- (void)registerUserNotification {
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        //iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
                
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];

    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)   {
       
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        
//        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeNewsstandContentAvailability |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge);
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }

    
    
    
}


/**
 *  SDK通知收到个推推送的透传消息
 *
 *  @param payloadData 推送消息内容
 *  @param taskId      推送消息的任务id
 *  @param msgId       推送消息的messageid
 *  @param offLine     是否是离线消息，YES.是离线消息
 *  @param appId       应用的appId
 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    //收到个推消息
    NSString *payloadMsg = nil;
    NSDictionary *dic = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
        
        dic = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingAllowFragments error:nil];
        
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : dic];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    
}




- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}



/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
    
    
}




- (void)registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);

    //向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}




- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    
    NSLog(@"ios 10 Notification %@",response);
    
//    UNNotification *noti = response.notification;
    
    NSDictionary *userInfo =  response.notification.request.content.userInfo ;

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;

    [self notificationWithUserInfo:userInfo];
}



- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;

    [self notificationWithUserInfo:userInfo];
}



- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(userInfo == nil){
        
        NSLog(@"Launching == %@",userInfo);
        return;
    }
    
    [self notificationWithUserInfo:userInfo];
}




- (void)notificationWithUserInfo:(NSDictionary *)userInfo {
    
    _userInfo = userInfo;
    
    if(_alert == nil){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您有一条消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
        _alert = alert;
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    _alert = nil;
    
    if(buttonIndex == 1){
                
        if(_responseBlock != nil){
            _responseBlock(_userInfo);
        }
    }
    
    
}




@end
