//
//  SuccessViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SuccessViewController.h"

#import "NianJianHeadView.h"
#import "YangHuHeadView.h"
#import "WeiXiuHeadView.h"

#import "OrderDetailViewController.h"

@interface SuccessViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;


@property (nonatomic ,strong)NianJianHeadView *nianjianHeadView;
@property (nonatomic ,strong)YangHuHeadView *yanghuHeadView;
@property (nonatomic ,strong)WeiXiuHeadView *weixiuHeadView;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"我的订单"];
    
//    self.selTag = [_shopModel.cateid integerValue];
    
    [self creatFootView];
    
//    [self setLeftBarWithCustomView:nil];
    
    [self initTableView];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NianJianHeadView*)nianjianHeadView {
    
    if(_nianjianHeadView == nil){
        _nianjianHeadView = [[NianJianHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 100)];
    }
    return _nianjianHeadView;
}

- (YangHuHeadView*)yanghuHeadView {
    
    if(_yanghuHeadView == nil){
        _yanghuHeadView = [[YangHuHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 100)];
    }
    return _yanghuHeadView;
}


- (WeiXiuHeadView*)weixiuHeadView {
    
    if(_weixiuHeadView == nil){
        _weixiuHeadView = [[WeiXiuHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 100)];
    }
    return _weixiuHeadView;
}






- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
    //    _tableView.separatorStyle = NO;
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
    [self loadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}




- (void)loadData {
    
    
    
    
    NSString *url = HOSTAPIKEY(@"api/public/orderdetail");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:_shopModel.serialnumber forKey:@"serialnumber"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            _model = [[OrderModel alloc]initWithDict:dict];
            [_model detailWithDict:dict];
            
            if(self.selTag == 1){
                
                self.tableView.tableHeaderView = self.nianjianHeadView;
                [self.nianjianHeadView dataWithModel:_model];
            }
            else if (self.selTag == 2){
                
                self.tableView.tableHeaderView = self.yanghuHeadView;
                [self.yanghuHeadView dataWithModel:_model];
            }
            else if (self.selTag == 3){
                
                self.tableView.tableHeaderView = self.weixiuHeadView;
                [self.weixiuHeadView dataWithModel:_model];
            }
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
    
    
    
    
}



- (void)creatFootView {
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - 50, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(40, 10, SCREEM_WIDTH/2 - 50, 32)];
    
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 4;
    btn1.layer.borderWidth = 1;
    btn1.layer.borderColor = RGB(250, 127, 124).CGColor;
    [btn1 setTitleColor:RGB(250, 127, 124) forState:UIControlStateNormal];
    [btn1 setTitle:@"返回首页" forState:UIControlStateNormal];
    [footView addSubview:btn1];
    
    btn1.titleLabel.font = FONT14;
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2+10, 10, SCREEM_WIDTH/2 - 50, 32)];
    
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 4;
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = MAINCOLOR.CGColor;
    [btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [btn2 setTitle:@"查看订单" forState:UIControlStateNormal];
    [footView addSubview:btn2];
    
    btn2.titleLabel.font = FONT14;
    
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [footView addSubview:line];
}


- (void)btn1Action {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)btn2Action {
    
    
    
    OrderModel *model = _model;
    
    OrderDetailViewController *nextVC = [[OrderDetailViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.selTag = self.selTag - 1;
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end
