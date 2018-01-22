//
//  RefleshManager.h
//  DongJie
//
//  Created by yuyue on 2017/5/24.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefleshManager : NSObject


+ (void)tableView:(UITableView*)tableView header:(SEL)headerAction footer:(SEL)footerAction ;


+ (void)tableView:(UITableView*)tableView count:(NSInteger)count maxCount:(NSInteger)maxCount ;


+ (void)tableView:(UITableView*)tableView  ;

@end
