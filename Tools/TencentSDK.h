//
//  TencentSDK.h
//  ThirdSDK
//
//  Created by yuyue on 16/9/22.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TencentSDK : NSObject
// 登录成功回调 block
@property (nonatomic,strong)void (^loginSuccess)();

// 登录成功回调 block
@property (nonatomic,strong)void (^loginBlock)(NSString *img, NSString*name ,NSString* uid);

// 分享失败回调 block
@property (nonatomic,strong)void (^loginFail)();
// 分享成功回调 block
@property (nonatomic,strong)void (^shareSuccess)();


/**
 * qq单例
 
 @return TencentSDK
 */
+ (TencentSDK *)shareTencentSDK ;

/**
 *处理qq 通过URL启动第三方应用时传递的数据
 
 *需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 启动第三方应用的URL
 
 */
-  (void)handleOpenURL:(NSURL *)url  ;


/**
 * qq 登录
 
 */
- (void)TencentLogin ;


/**
 * qq 分享
 
 */
- (void)tencentShareQQ ;

/**
 * qq 空间分享
 
 */
- (void)tencentShareZone ;



@end
