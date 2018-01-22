//
//  WXApiManager.m
//  Aladdin
//
//  Created by yuyue on 2017/3/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "WXApiManager.h"


#import "WXApi.h"

#import "SKShareText.h"

@interface WXApiManager ()<WXApiDelegate>

@end

@implementation WXApiManager

static WXApiManager * wxApiManager = nil;



/**
 *  创建支付单例服务
 *
 *  @return 返回单例对象
 */
+ (WXApiManager * ) shareInstance {
    
    if(wxApiManager == nil) {
        
        wxApiManager = [[WXApiManager alloc]init];
    }
    
    return wxApiManager;
}



- (instancetype)init {
    
    self = [super init];
    
    [WXApi registerApp:WXID];
    
    return self;
}



/*
 *! @brief 处理微信通过URL启动App时传递的数据
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 微信启动第三方应用时传递过来的URL
 
 */

-  (void)handleOpenURL:(NSURL *)url {
    
    [WXApi handleOpenURL:url delegate:self];
}




/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req {
    
    
}


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp {
    
    
    if(resp.errCode == WXSuccess){
        
        if([resp isKindOfClass:[SendMessageToWXResp class]]) {
            
            if(_shareSuccess != nil){
                _shareSuccess();
            }
        }
        else if ([resp isKindOfClass:[PayResp class]]){
            
            if(_paySuccess != nil){
                _paySuccess();
            }
        }
        else if ([resp isKindOfClass:[SendAuthResp class]]){
         
//            [self loginSuccessByCode:((SendAuthResp*)resp).code];

        }
        
        
    }
    


}


/**
 * 微信分享
 * 微信 用单例使用
 
 */

- (void)wxPayWithDict:(NSDictionary*)dict {
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = [dict objectForKey:@"sign"];
    
    
    BOOL results =  [WXApi sendReq:req];
    
    NSLog(@"results = %@",@(results));
    
    //日志输出
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
}


- (void)wxShareSession {
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        WXWebpageObject*webpage = [WXWebpageObject object];
        webpage.webpageUrl = SHARE_URL;
        
        WXMediaMessage * message = [WXMediaMessage message];
        // (WXMediaMessage*)webpage;
        [message setThumbImage:[UIImage imageNamed:SHARE_IMG]];
        message.title = SHARE_TIT;
        message.description = SHARE_TXT;
        message.thumbData = UIImagePNGRepresentation([UIImage imageNamed:@"icon_session.jpg"]);
        message.mediaObject = webpage;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = @"";
        req.bText = NO;
        req.scene = WXSceneSession;//分享场景设置
        req.message = message;
        [WXApi sendReq:req];
    }
    else
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        
        [alView show];
    }
    
    
}





- (void)wxShareTimeline {
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        WXWebpageObject*webpage = [WXWebpageObject object];
        webpage.webpageUrl = SHARE_URL;
        
        WXMediaMessage * message = [WXMediaMessage message];
        // (WXMediaMessage*)webpage;
        [message setThumbImage:[UIImage imageNamed:SHARE_IMG]];
        message.title = SHARE_TIT;
        message.description = SHARE_TXT;
        message.thumbData = UIImagePNGRepresentation([UIImage imageNamed:@"icon_session.jpg"]);
        message.mediaObject = webpage;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = @"";
        req.bText = NO;
        req.scene = WXSceneTimeline;//分享场景设置
        req.message = message;
        [WXApi sendReq:req];
    }
    else
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你还没有安装微信,无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        
        [alView show];
    }
    
    
}






@end
