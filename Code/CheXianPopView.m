//
//  CheXianPopView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/11/2.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CheXianPopView.h"


@interface CheXianPopView ()<UIGestureRecognizerDelegate ,UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSMutableArray* tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *customView;


@property (nonatomic ,strong)ShopModel *model;

@property (nonatomic ,copy)ActionBlock successBlock;

@end


@implementation CheXianPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




+ (void)showInView:(UIView*)view shopModel:(ShopModel*)model success:(ActionBlock)success {
    
    CheXianPopView * popView = [[CheXianPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.successBlock = success;
    popView.model = model;
    [view addSubview:popView];
    

    
    [popView show];
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    
    _dataSource = [NSMutableArray arrayWithArray:@[@"交强险",@"车船税",@"车损险",
                                                   @"全车盗抢险",@"第三者责任险",@"不计免赔险",
                                                   @"机动车上人员责任保险（司机)",
                                                   @"机动车上人员责任保险（乘客）",@"单独玻璃破碎险",
                                                   @"划痕险",@"自燃险",@"修理期间补偿险",
                                                   @"车上货物责任险发动机涉水损失险",
                                                   @"指定修理厂险",@"机动车损失保险无法找到第三方特约险",
                                                   @"精神损害抚慰金责任险",@"设备损失险"]];
    
    
    _tableArr = [NSMutableArray array];
    
    [self creatView];
    
    return self;
}

#pragma mark - 让视图消失的方法
//解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    
    if (point.y < _customView.top) {
        
        return YES;
    }
    return NO;
}

- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    tap.delegate = self;
    [bgView addGestureRecognizer:tap];
    
    CGFloat hhh = 44;
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 240)];
    
    _customView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_customView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, hhh)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT14;
    [_customView addSubview:btn1];
    [btn1 addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, 0, 80, hhh)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT14;
    [_customView addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self initTableView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [_customView addSubview:line];
}





- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEM_WIDTH, _customView.height - 44)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [_customView addSubview:_tableView];
    
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
    
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
//    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
//    
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    
//    [footer endRefreshingWithNoMoreData];
//    
//    
//    _tableView.mj_footer = footer;
    
    //    _tableView.separatorStyle = NO;
 
    
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
   
    
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
        cell.selectionStyle = NO;
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    NSString *cate = self.dataSource[indexPath.row];
    
    cell.textLabel.font = FONT14;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    
    BOOL isHas = [_tableArr containsObject:cate];
    
    if(isHas) {
        cell.textLabel.textColor = MAINCOLOR;
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"idcard_btn"]];
    }
    else {
        cell.textLabel.textColor = RGB(25, 25, 25);
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"idcard_btn_n"]];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cate = self.dataSource[indexPath.row];
    
    
    BOOL isHas = [_tableArr containsObject:cate];
    
    if(isHas == NO){
    
        [_tableArr addObject:cate];
    }
    else {
        [_tableArr removeObject:cate];
    }
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



- (void)leftBtnAction {
    
    [self hide];
}




- (void)btnAction {
    
    
    NSString * zhonglei = @"";
    
    for(int i=0;i<_tableArr.count;i++){
        
        zhonglei = [zhonglei stringByAppendingString:_tableArr[i]];
        
        if(i<_tableArr.count - 1){
            zhonglei = [zhonglei stringByAppendingString:@","];
        }
    }
    
    _model.zhonglei = zhonglei;
    
    [self hide];
    
    if(_successBlock != nil){
        _successBlock();
    }
}


- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT - _customView.height, SCREEM_WIDTH, _customView.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, _customView.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}





@end
