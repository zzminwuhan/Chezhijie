//
//  TencentSDK.m
//  ThirdSDK
//
//  Created by yuyue on 16/9/22.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "TencentSDK.h"

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>


#import "SKShareText.h"




static TencentSDK *tencentSDK = nil;

@interface TencentSDK ()<TencentSessionDelegate , TencentLoginDelegate ,QQApiInterfaceDelegate>

@property (nonatomic, retain)TencentOAuth *oauth;

@end


@implementation TencentSDK




+ (TencentSDK *)shareTencentSDK {
    
    if(tencentSDK == nil){
        
        tencentSDK = [[TencentSDK alloc]init];
    }
    
    return tencentSDK;
}


- (instancetype)init {
    
    self = [super init];
    
    self.oauth =  [[TencentOAuth alloc] initWithAppId:QQID andDelegate:self];
    [self.oauth openSDKWebViewQQShareEnable];
    
    return self;
}





- (void)TencentLogin {
    
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [self.oauth authorize:permissions inSafari:NO];
 

}


- (void)getUserInfoResponse:(APIResponse*) response {
    
    
    if(URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode) {
        
        NSDictionary *dic = response.jsonResponse ;
        
        NSString *name = dic[@"nickname"];
        NSString *img = dic[@"figureurl_qq_1"];
        NSString *uid = self.oauth.openId;
        
        NSLog(@"uid = %@ \nname = %@ \nimg = %@",uid,name,img);
        
        if(_loginBlock != nil){
            _loginBlock(img ,name ,uid);
        }
        
    }
    
}



/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    
    BOOL  isLogin = [self.oauth getUserInfo];
    
    if(_loginSuccess != nil && isLogin == YES){
        _loginSuccess () ;
    }
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    
    if(_loginFail != nil){
        _loginFail () ;
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    
    
}




- (void)tencentShareQQ {
    
    
    if([TencentOAuth iphoneQQInstalled]==NO)
    {
        [self openShareQQ];
        return;
    }
    
    NSString *url = SHARE_URL;
    UIImage *img = [UIImage imageNamed:SHARE_IMG];
    NSData * data = UIImagePNGRepresentation(img);
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]                                title: SHARE_TIT description:SHARE_TXT previewImageData:data];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];

    //将内容分享到qzone
//    QQApiSendResultCode sent =  [QQApiInterface sendReq:req];
    
    if(sent == EQQAPISENDSUCESS) {
        
        
    }

}



-  (void)handleOpenURL:(NSURL *)url {
    
    
    [QQApiInterface handleOpenURL:url delegate:self];
}




- (void)tencentShareZone {
    
    
    if([TencentOAuth iphoneQQInstalled]==NO)
    {
        [self openShareZone];
        return;
    }
    
    NSString *url = SHARE_URL;
    UIImage *img = [UIImage imageNamed:SHARE_IMG];
    NSData * data = UIImagePNGRepresentation(img);
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]                                title: SHARE_TIT description:SHARE_TXT previewImageData:data];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];

    //将内容分享到qzone
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    
    if(sent == EQQAPISENDSUCESS) {
        
    
    }
    
}


/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    
    
//    NSString * str = [NSString stringWithFormat:@"%@",req];
//    
//    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"req", nil];
//    [alView show];
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    
    // 响应类型  分享
    if([resp class] == [SendMessageToQQResp class]){
        
        if([resp.result integerValue] == 0){
            
            if (_shareSuccess !=nil) {
                _shareSuccess();
            }
            
        }
    }
    
    
//    NSString * str = [NSString stringWithFormat:@"%@",resp.result];
//    
//    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"resp", nil];
//    [alView show];
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    
    
    
}



- (void)openShareQQ {
    
    
    NSString * str = [NSString stringWithFormat:@"http://openmobile.qq.com/api/check?style=9&targeturl=%@&sdkp=i&appId=%@&status_version=9&title=%@&summary=%@&sdkv=2.9&status_machine=x86_64&status_os=9.3&page=shareindex.html",SHARE_URL,QQID,SHARE_TIT,SHARE_TXT];
    
    
    [self openURL:str];
}


- (void)openShareZone {
    
    
    NSString * str = [NSString stringWithFormat:@"http://qzs.qzone.qq.com/open/connect/widget/mobile/qzshare/index.html?appId=%@&loginpage=loginindex.html&logintype=qzone&page=qzshare.html&referer=(null)&sdkp=i&sdkv=2.9&sid=&status_machine=x86_64&status_os=9.3&status_version=9&summary=%@&targeturl=%@&title=%@&t=1474537808893",QQID,SHARE_TXT ,SHARE_URL,SHARE_TIT];
    
    [self openURL:str];
}


- (void)openURL:(NSString *)str {
    
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}







@end
