//
//  GeTuiManager.h
//  Aladdin
//
//  Created by yuyue on 2017/3/29.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GeTuiSdk.h>

@interface GeTuiManager : NSObject



+ (GeTuiManager*)shareInstance ;


- (void)registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken ;


- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo ;


- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions ;



@property (nonatomic ,copy)void (^responseBlock)(NSDictionary *userInfo);



- (BOOL)isOpen ;


- (void)setIsOpen:(BOOL)isOpen ;


@end
