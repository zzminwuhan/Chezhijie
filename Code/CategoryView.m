//
//  CategoryView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CategoryView.h"


@interface CategoryView ()

@property (nonatomic ,assign)NSInteger leftSelTag;

@property (nonatomic ,assign)NSInteger rightSelTag;

@end

@implementation CategoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    _leftSelTag = 0;
    _rightSelTag = -1;
    [self creatView];
//    self.hidden = YES;
    _isShow = YES;
    
    return self;
}


- (void)creatView {
    
    [self initTableView];
    
}


- (void)setIsShow:(BOOL)isShow {
    
    _isShow = isShow;
    
    if(isShow == YES){
        [self show];
    }
    else {
        [self hide];
    }
    
}

- (void)show {
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0, 0, self.width, self.height);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hide {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(-self.width, 0, self.width, self.height);
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}




- (void)setLeftArray:(NSMutableArray *)leftArray {
    
    _leftArray = leftArray;
    [_leftTableView reloadData];
}


- (void)setRightArray:(NSMutableArray *)rightArray {
    
    _rightArray = rightArray;
    [_rightTableView reloadData];
}


- (void)initTableView  {
    
    
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height - 0)];
    _leftTableView.dataSource = self;
    
    _leftTableView.delegate = self;
    
    [self addSubview:_leftTableView];
    
    if([_leftTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_leftTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([_leftTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_leftTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    _leftTableView.tableFooterView = [[UIView alloc] init];
    _leftTableView.backgroundColor = [UIColor whiteColor];
    
    
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2, self.height - 0 )];
    _rightTableView.dataSource = self;
    
    _rightTableView.delegate = self;
    
    [self addSubview:_rightTableView];
    
    if([_rightTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_rightTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([_rightTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_rightTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    _rightTableView.tableFooterView = [[UIView alloc] init];
    _rightTableView.backgroundColor = [UIColor whiteColor];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == _leftTableView){
        
        return _leftArray.count;
    }
    else if (tableView == _rightTableView ){
        return _rightArray.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.font = FONT14;
    cell.textLabel.textColor = RGB(50, 50, 50);
    
    if(tableView == _leftTableView){
        
        if(_leftArray.count <= 0){
            return cell;
        }
        CategoryModel * model = _leftArray[indexPath.row];
        
        cell.textLabel.text = model.name;
        if(_leftSelTag == indexPath.row){
            cell.contentView.backgroundColor = RGB(255, 255, 255);
            cell.textLabel.textColor = MAINCOLOR;

        }
        else {
            cell.contentView.backgroundColor = RGB(240, 240, 240);
            cell.textLabel.textColor = RGB(200, 200, 200);
        }
        
    }
    else if (tableView == _rightTableView){
        
        if(_rightArray.count <= 0){
            return cell;
        }
        CategoryModel * model = _rightArray[indexPath.row];
        
        cell.textLabel.text = model.name;
        cell.contentView.backgroundColor = RGB(255, 255, 255);
     
        if(_rightSelTag == indexPath.row){
//            cell.contentView.backgroundColor = RGB(255, 255, 255);
            cell.textLabel.textColor = MAINCOLOR;
            
        }
        else {
//            cell.contentView.backgroundColor = RGB(240, 240, 240);
            cell.textLabel.textColor = RGB(200, 200, 200);
        }
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == _leftTableView){
        
        _leftSelTag = indexPath.row;
        _rightSelTag = -1;
        
        if(_leftSelectBlock != nil){
            _leftSelectBlock(indexPath.row);
        }
     
        [_leftTableView reloadData];
    }
    else if (tableView == _rightTableView){
        
        _rightSelTag = indexPath.row;
        
        _rightSelTag = indexPath.row;
        if(_rightSelectBlock != nil){
            _rightSelectBlock(indexPath.row);
        }
        
        self.isShow = NO;
    }

}




@end
