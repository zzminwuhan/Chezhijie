//
//  HMNewViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HMNewViewController.h"

#import "HomeDetailViewController.h"

#import "MessageTableViewCell.h"

@interface HMNewViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation HMNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"新闻资讯"];
    
    self.dataSource = [NSMutableArray array];
    
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





- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 0)];
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
    
    _tableView.separatorStyle = NO;
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
    MessageTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    MessageModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *model = _dataSource[indexPath.row];
    HomeDetailViewController *nextVC = [[HomeDetailViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:YES];
}





- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/newslist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 10;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *newslist = dict[@"elements"];
            
            for(NSDictionary *dic2 in newslist){
                
                MessageModel *model = [[MessageModel alloc]initWithDict:dic2];
                [_dataSource addObject:model];
            }
            
            [self.tableView reloadData];
            
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];

}


@end
