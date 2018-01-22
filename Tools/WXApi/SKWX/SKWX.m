//
//  SKWX.m
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "SKWX.h"


#import "WXApi.h"

#import "SKShareText.h"






static SKWX * wxSDK = nil;



@interface SKWX ()<WXApiDelegate>

@end

@implementation SKWX





+ (SKWX * )shareSdkWX {
    
    if(wxSDK == nil){
        
        wxSDK = [[SKWX alloc]init];
    }
    
    
    
    return wxSDK;
}



- (instancetype)init {
    
    self = [super init];
    
    [WXApi registerApp:WXID];
    
    
//    [WXApi registerApp:@""];
    
    return self;
}




- (void)wxLogin {
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
        
    }
    else {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendAuthReq:req viewController:self.VC delegate:self];
        
    }
    
}



- (void)wxPayURL:(NSString*)urlString {
    
    
    //    if([WXApi isWXAppInstalled]==NO)
    //    {
    //
    //        return;
    //    }
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ( response != nil)
    {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil)
        {
            NSMutableString *retcode = [dict objectForKey:@"res"];
            if (retcode.intValue == 1)
            {
                
                [self wxPayWithDict:dict];
                
                
            }
            else
            {
                
                
                NSString * msg = [NSString stringWithFormat:@"%@",dict[@"msg"]];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                [alert show];
            }
        }
        else
        {
            
        }
    }
    else
    {
        
        
    }
}



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
    
    
    BOOL ispay = [WXApi sendReq:req];
    //日志输出
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    
    NSLog(@"%@",@(ispay));
    
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
        req.text = @"工购网";
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
        req.text = @"工购网";
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
    
//    NSString * str = [NSString stringWithFormat:@"%@ == %d",resp ,resp.errCode];
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
        if(resp.errCode == WXSuccess){
            
            
            if(_shareSuccess != nil){
                _shareSuccess();
            }
        }
        
    }
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        if(resp.errCode == WXSuccess){
            
            if(_paySuccess != nil){
                _paySuccess();
            }
        }
        
        
    }
    
    
    
    if([resp isKindOfClass:[SendAuthResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        if(resp.errCode == WXSuccess){
            
            //            str = [NSString stringWithFormat:@"code=%@\n state=%@\n lang=%@\n country=%@",((SendAuthResp*)resp).code ,((SendAuthResp*)resp).state ,((SendAuthResp*)resp).lang ,((SendAuthResp*)resp).country];
            
            [self loginSuccessByCode:((SendAuthResp*)resp).code];
        }
        
        
        
    }
    
    
    
    
    //    [SdkWX showMsg:str];
}



-(void)loginSuccessByCode:(NSString *)code {
    
    NSString * urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXID,WXSECRET,code];
    
    NSURL*url = [NSURL URLWithString:urlStr];
    
    NSURLRequest*request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data.length >0&&[(NSHTTPURLResponse*)response statusCode]==200) {
            
            NSDictionary*dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSString * access_token = dict[@"access_token"];
            NSString * openid = dict[@"openid"];
            
            if(access_token != nil && openid != nil){
                
                [self requestUserInfoByToken:access_token andOpenid:openid];
            }
            else {
                
                NSString * str = [NSString stringWithFormat:@" dict == %@ ",dict];
                
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"resp", nil];

                [alView show];
            }
            
            
         
        }
    }];
    
}


-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID {
    
    NSString * urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID];
    
    NSURL*url = [NSURL URLWithString:urlStr];
    
    NSURLRequest*request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data.length>0&&[(NSHTTPURLResponse*)response statusCode]==200)
        {
            
            NSDictionary*dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSString * str = [NSString stringWithFormat:@" dict == %@ ",dict];
            
            NSString *name = dict[@"nickname"];
            NSString *img = dict[@"headimgurl"];
            NSString *uid = dict[@"openid"];
            
            if(_loginBlock != nil){
                
                _loginBlock(img , name, uid);
            }
            
            NSLog(@"log message %@",str);
            
                
//                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"resp", nil];
//                
//                [alView show];
            
        }
    }];
    
    
    
}



+ (void)showMsg:(NSString *)msg {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
    
    [alert show];
    
}




@end
