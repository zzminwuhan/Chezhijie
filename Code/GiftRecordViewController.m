//
//  GiftRecordViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "GiftRecordViewController.h"

#import "GiftRecordTableViewCell.h"

#import "HDQMenuView.h"

@interface GiftRecordViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,assign)NSInteger selTag;

@end

@implementation GiftRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"礼品记录"];
    
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



- (void)creatMenu {
    
    HDQMenuView *menuView = [[HDQMenuView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    
    menuView.titleArray = @[@"全部",@"待收货",@"已完成"];
    
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
    GiftRecordTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[GiftRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    GiftRecordModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    cell.downBlock = ^{
        
        if([model.status isEqualToString:@"2"]){
            
            [self downRecordWithModel:model];
        }
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //    HomeDetailViewController *nextVC = [[HomeDetailViewController alloc]init];
    //    nextVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:nextVC animated:YES];
}



- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/prizeorderlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 10;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    NSInteger status = _selTag == 0?0:_selTag+1;
    
    [parameters setObject:@(status) forKey:@"status"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            for(NSDictionary *dic1 in array){
                
                GiftRecordModel *model = [[GiftRecordModel alloc]initWithDict:dic1];
                
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
        label.text = @"暂无记录";
        label.textAlignment = NSTextAlignmentCenter;
        
        _tableView.tableFooterView = label;
    }
    else {
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
}


- (void)downRecordWithModel:(GiftRecordModel*)model {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/ConfirmReceive");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:model.Id forKey:@"orderid"];
  
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            [_dataSource removeAllObjects];
            [self loadData];
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}



@end
