//
//  SettingsViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsViewController.h"

#import "EditPwdViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"设置"];
    
    self.dataSource = [NSMutableArray array];
    
    [self.dataSource addObject:@"清空缓存"];
    [self.dataSource addObject:@"修改密码"];

    
    [self initTableView];
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
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 64)];
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
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 200)];
    _tableView.tableFooterView = footView;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [footView addSubview:line];
    
    CGRect loginf = CGRectMake(30, 150, SCREEM_WIDTH - 60, 44);
    UIButton *login = [[UIButton alloc]initWithFrame:loginf ];
    login.backgroundColor = MAINCOLOR;
    [login setTitle:@"退出登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font = FONT15;
    //    login.layer.masksToBounds = YES;
    //    login.layer.cornerRadius = login.height/2;
    [footView addSubview:login];
    
    [login addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)submitBtnAction {
    
    [UserManager quitAction];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"quitnotification" object:nil];
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
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    cell.textLabel.font = FONT15;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
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
    
    if(indexPath.row == 1){
        
        EditPwdViewController *nextVC = [[EditPwdViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (indexPath.row == 0){
        
        [NetWorkManager clearCache];
    }
}



@end
