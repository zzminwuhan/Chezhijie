//
//  RefleshManager.m
//  DongJie
//
//  Created by yuyue on 2017/5/24.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "RefleshManager.h"

@implementation RefleshManager




+ (void)tableView:(UITableView*)tableView header:(SEL)headerAction footer:(SEL)footerAction {
    
    
//    [tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:headerAction];
//    
//    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:headerAction];
//    
//    [tableView.footer setTitle:@"123" forState:MJRefreshFooterStateNoMoreData];
//    [tableView.footer noticeNoMoreData];
    
}



+ (void)tableView:(UITableView*)tableView count:(NSInteger)count maxCount:(NSInteger)maxCount {
    
    [tableView.mj_header endRefreshing];
    if(count < maxCount){
        [tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [tableView.mj_footer resetNoMoreData];
    }
    
}


+ (void)tableView:(UITableView*)tableView  {
    
    

    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [tableView.mj_header beginRefreshing];
    }];
    
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
//    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
//    
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    
//    [footer endRefreshingWithNoMoreData];
    
}





@end
