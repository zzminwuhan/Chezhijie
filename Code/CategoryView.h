//
//  CategoryView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryModel.h"

@interface CategoryView : UIView <UITableViewDelegate,UITableViewDataSource  >

@property (strong,nonatomic)UITableView*leftTableView;
@property (strong,nonatomic)UITableView*rightTableView;
@property (strong,nonatomic)NSMutableArray* leftArray;
@property (nonatomic,strong)NSMutableArray* rightArray;

@property (nonatomic ,copy)void (^leftSelectBlock)(NSInteger index);
@property (nonatomic ,copy)void (^rightSelectBlock)(NSInteger index);


@property (nonatomic ,assign)BOOL isShow;


- (void)show ;

- (void)hide ;

@end
