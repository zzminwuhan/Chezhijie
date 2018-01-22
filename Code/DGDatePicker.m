//
//  DGDatePicker.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DGDatePicker.h"


@interface DGDatePicker ()


@property (nonatomic ,strong)UIView *customView;


@end


@implementation DGDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/






- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    
    [self creatView];
    
    [self initTableView];
    
    return self;
}


- (void)bgColorTap:(UITapGestureRecognizer*)tap {
    
//    [self hide];
}


- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgColorTap:)];
    [bgView addGestureRecognizer:tap];
    
    
    [self initTableView];
}






- (void)initTableView  {
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, SCREEM_WIDTH, 44*5)];
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.width, self.customView.height - 0  - 44)];
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
    _tableView.backgroundColor = [UIColor whiteColor];
    
    
    UIToolbar *myToolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEM_WIDTH, 44.0f)];
    [_customView addSubview:myToolBar];
    
   
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [myToolBar addSubview:btn];
    btn.titleLabel.font = FONT14;
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 60, 0, 60, 44)];
    
    [btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [myToolBar addSubview:btn2];
    btn2.titleLabel.font = FONT14;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];

}



- (void)btnAction {
    
    [self hide];
}


- (void)btn2Action {
    
    [self hide];
    
    if(_SelDateString != nil){
        _SelDateString(self.selStr);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    NSString * model = _dataSource[indexPath.row];
    
    cell.textLabel.text = model;

    
    if([model isEqualToString:_selStr]){
        
        cell.textLabel.font = FONT15;
        cell.textLabel.textColor = MAINCOLOR;
    }
    else {
        cell.textLabel.font = FONT14;
        cell.textLabel.textColor = RGB(50, 50, 50);
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selStr = _dataSource[indexPath.row];
    
    [_tableView reloadData];
}



- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, self.height, self.width, _customView.height);
    } completion:^(BOOL finished) {
    
        [self removeFromSuperview];
    }];
    
}


- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, self.height - _customView.height, _customView.width, _customView.height);
        
    } completion:^(BOOL finished) {
        
    }];
}



- (void)setDataSource:(NSMutableArray *)dataSource {
    
    _dataSource = dataSource;
    
    [_tableView reloadData];
}



+ (NSMutableArray *)getCurrentDateArray {
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
                              
    NSInteger year = comp.year;
    
    
    for(NSInteger i = year ;i > (year - 50 );i--){
        
        NSString *date = [NSString stringWithFormat:@"%@",@(i)];
        [dateArray addObject:date];
    }
    

    return dateArray;
}




@end
