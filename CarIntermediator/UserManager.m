//
//  UserManager.m
//  DemoBaseVC
//
//  Created by yuyue on 15-11-10.
//  Copyright (c) 2015年 incredibleRon. All rights reserved.
//

#import "UserManager.h"




//NSString *const LoginNotification = @"LoginNotification";
//NSString *const QuitNotification = @"QuitNotification";

static UserManager *user = nil;


@implementation UserManager



+ (BOOL)isLogin {
    
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"authtoken"];

    if(token == nil){
        return NO;
    }

    return YES;
}



+ (void)loginWithToken:(NSString*)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"authtoken"];
    
}


+ (NSString*)getToken {
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"authtoken"];
    
    if(token == nil){
        token = @"";
    }
    
    return token;
}



+ (void)quitAction {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authtoken"];
}










@end
