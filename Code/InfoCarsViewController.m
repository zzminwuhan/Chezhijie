//
//  InfoCarsViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoCarsViewController.h"

#import "InfoCarsTableViewCell.h"

#import "CarCreateViewController.h"
#import "CarEditViewController.h"

@interface InfoCarsViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic,strong)CarModel* selmodel;

@end

@implementation InfoCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"我的车辆"];
    
    self.dataSource = [NSMutableArray array];
    
    [self initTableView];
    
    [self initRightItem];
    
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


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT12;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
}


- (void)rightItemAction {
   
    
    
    
   
    CarCreateViewController *nextVC = [[CarCreateViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    nextVC.successBlock = ^{
      
        [_dataSource removeAllObjects];
        [self loadData];
    };
}







- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0 - 64)];
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
    InfoCarsTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[InfoCarsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    CarModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    if(model == _selmodel){
        
        cell.btn1.selected = YES;
    }
    else {
     
        cell.btn1.selected = NO;
    }
    
    
    cell.delBlock = ^{
        
        [self delWithModel:model];
    };
    
    cell.editBlock = ^{
        
        CarEditViewController *nextVC = [[CarEditViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.model = model;
        [self.navigationController pushViewController:nextVC animated:YES];
        nextVC.successBlock = ^{
            
            [_dataSource removeAllObjects];
            [self loadData];
        };
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
    
    CarModel *model = _dataSource[indexPath.row];
    
    _selmodel = model;
    
//    [_tableView reloadData];
    
    if(_selCarBlock != nil){
        
        _selCarBlock(_selmodel);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}



/*
 * 消息列表
 *
 */

- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/carlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 10;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            for(NSDictionary *dic1 in array){
                
                CarModel *model = [[CarModel alloc]initWithDict:dic1];
                
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
        label.text = @"暂无车辆";
        label.textAlignment = NSTextAlignmentCenter;
        
        _tableView.tableFooterView = label;
    }
    else {
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
}




- (void)delWithModel:(CarModel*)model {
    
    NSString *url = HOSTAPIKEY(@"api/public/delcar");
    
    NSString * token = [UserManager getToken];
    
    NSString * Id = model.Id;

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:Id forKey:@"id"];
    

    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            [_dataSource removeObject:model];
            [_tableView reloadData];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];

}




@end
