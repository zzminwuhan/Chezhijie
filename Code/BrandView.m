//
//  BrandView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BrandView.h"

@implementation BrandView

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
    
    return self;
}




- (void)bgColorTap:(UITapGestureRecognizer*)tap {
    
     [self hide];
}


- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2, 44)];
    
    _label.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_label];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2, 44-0.5, self.width/2, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgColorTap:)];
    [bgView addGestureRecognizer:tap];
    
    
    [self initTableView];
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width/2, 44, self.width/2, self.height - 0  - 44)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self addSubview:_tableView];
    
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
    
    BrandModel * model = _dataSource[indexPath.row];
    
    cell.textLabel.text = model.name;
    
    cell.textLabel.font = FONT14;
    cell.textLabel.textColor = RGB(50, 50, 50);
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BrandModel * model = _dataSource[indexPath.row];

    if(_selModel != nil){
        _selModel(model);
    }
    
//    [self hide];
}



- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.frame = CGRectMake(-self.width, 0, self.width, self.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}



- (void)setDataSource:(NSMutableArray *)dataSource {
    
    _dataSource = dataSource;
    
    [_tableView reloadData];
}



- (void)setAttr:(NSString *)attr {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 0;// 字体的行间距
    paragraphStyle.headIndent = 15.f;
    paragraphStyle.firstLineHeadIndent = 15.f;//首行缩进
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT14,NSForegroundColorAttributeName:RGB(50, 50, 50), NSParagraphStyleAttributeName:paragraphStyle};
   
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:attr attributes:attributes1];
 
    
    [attrStr appendAttributedString:attr1];
 
    _label.attributedText = attrStr;
}


@end
