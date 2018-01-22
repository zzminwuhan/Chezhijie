//
//  InfoOrderViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoOrderViewController.h"

#import "IOrderMenu.h"

#import "IOrderTableViewCell.h"

#import "OrderDetailViewController.h"

#import "PhoneView.h"

@interface InfoOrderViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,assign)NSInteger selTag;

@end

@implementation InfoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"我的订单"];
    
    self.dataSource = [NSMutableArray array];
    
    [self creatMenu];
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)creatMenu {
    
    IOrderMenu *menuView = [[IOrderMenu alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    
    menuView.titleArray = @[@"年检",@"养护",@"维修"];
    
    [menuView setBtnSelWithTag:^(NSInteger tag){
        
        _selTag = tag;
        
        [_dataSource removeAllObjects];
        
        //        [_tableView.mj_header beginRefreshing];
        
        [self loadData];
    }];
    
    [self.view addSubview:menuView];
    
}






- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40  - 64)];
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
    _tableView.backgroundColor = GRAYCOLOR;
    
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
    IOrderTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[IOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    OrderModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    cell.phoneBlock = ^{
        
        [PhoneView showInWindowWithPhone:model.mobile];
    };
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderModel *model = _dataSource[indexPath.row];
    
    OrderDetailViewController *nextVC = [[OrderDetailViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.selTag = self.selTag;
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:YES];
}



/*
 * 消息列表
 *
 */

- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/orderlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 10;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [parameters setObject:@(_selTag+1) forKey:@"type"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            for(NSDictionary *dic1 in array){
                
                OrderModel *model = [[OrderModel alloc]initWithDict:dic1];
                model.selTag = _selTag+1;
                [_dataSource addObject:model];
            }
            
            [_tableView reloadData];
            
            [RefleshManager tableView:_tableView count:array.count maxCount:pageCount];
         
            [self tipViewAlert];
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}



- (void)tipViewAlert {
    
    
    if(_dataSource.count <= 0){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64*2)];
        label.text = @"暂无订单";
        label.textAlignment = NSTextAlignmentCenter;
        
        _tableView.tableFooterView = label;
    }
    else {
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
}



@end
