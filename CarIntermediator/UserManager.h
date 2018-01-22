//
//  UserManager.h
//  DemoBaseVC
//
//  Created by yuyue on 15-11-10.
//  Copyright (c) 2015年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserManager : NSObject


+ (BOOL)isLogin ;

+ (void)loginWithToken:(NSString*)token  ;

+ (NSString*)getToken ;

+ (void)quitAction ;

@end
