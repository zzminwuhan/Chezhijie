//
//  SKWX.h
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface SKWX : NSObject



@property (nonatomic,strong) UIViewController *VC;


@property (nonatomic,strong)void (^loginSuccess)();

@property (nonatomic,strong)void (^loginBlock)(NSString *img, NSString*name ,NSString* uid);

@property (nonatomic,strong)void (^loginFail)();

@property (nonatomic,strong)void (^shareSuccess)();

@property (nonatomic,strong)void (^paySuccess)();

/**
 * 微信单例
 
 
 */
+ (SKWX * )shareSdkWX ;



/**
 *处理微信 通过URL启动第三方应用时传递的数据
 
 *需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 启动第三方应用的URL
 
 */
-  (void)handleOpenURL:(NSURL *)url  ;

/**
 * 微信登陆
 
 */
- (void)wxLogin ;

/**
 * 微信分享
 
 */
- (void)wxShareSession ;

/**
 * 微信朋友圈分享
 
 */
- (void)wxShareTimeline ;


/**
 * 微信支付
 @program urlString 支付接口
 */
- (void)wxPayURL:(NSString*)urlString  ;



- (void)wxPayWithDict:(NSDictionary*)dict ;

@end
