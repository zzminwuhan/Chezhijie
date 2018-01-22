//
//  WXApiManager.h
//  Aladdin
//
//  Created by yuyue on 2017/3/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXApiManager : NSObject


@property (nonatomic,strong)void (^loginSuccess)();

@property (nonatomic,strong)void (^loginFail)();

@property (nonatomic,strong)void (^shareSuccess)();

@property (nonatomic,strong)void (^paySuccess)();


/**
 *  创建单例服务
 *
 *  @return 返回单例对象
 */
+ (WXApiManager * ) shareInstance ;



/*
 *! @brief 处理微信通过URL启动App时传递的数据
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 微信启动第三方应用时传递过来的URL
 
 */
-  (void)handleOpenURL:(NSURL *)url ;



/**
 * 微信分享
 * 微信 用单例使用
 
 */
- (void)wxShareSession ;

/**
 * 微信朋友圈分享
 * 微信 用单例使用
 
 */
- (void)wxShareTimeline ;



- (void)wxPayWithDict:(NSDictionary*)dict ;


@end
