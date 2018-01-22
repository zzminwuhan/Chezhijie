//
//  ShopPickerView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ShopPickerView.h"


@interface ShopPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong)UIPickerView *pickerView;

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)NSMutableArray *shopArr;

@property (nonatomic ,copy)ShopSelBlock successBlock;

@property (nonatomic ,strong)ShopModel *selModel;

@end

@implementation ShopPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (void)showInView:(UIView*)view array:(NSMutableArray*)array success:(ShopSelBlock)success {
    
    ShopPickerView * popView = [[ShopPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.successBlock = success;
    [view addSubview:popView];
    
    popView.shopArr = array;
    
    if(array.count > 0){
        
        ShopModel *model = array[0];
        popView.selModel = model;
    }
    [popView.pickerView reloadAllComponents];
    
    [popView show];
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    
    [self creatView];
    
    return self;
}






- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    
    [bgView addGestureRecognizer:tap];
    
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 240)];
    
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    
    [self addCustomView];
}



- (void)addCustomView {
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 44)];
    btnView.backgroundColor = RGB(230, 230, 230);
    [_customView addSubview:btnView];
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, btnView.height)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT14;
    [_customView addSubview:btn1];
    [btn1 addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, 0, 80, btnView.height)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT14;
    [_customView addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, btnView.height, SCREEM_WIDTH, _customView.height - btnView.height)];
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_customView addSubview:_pickerView];
    
}



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    return _shopArr.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    ShopModel *model = _shopArr[row];
  
    return model.name;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   
    _selModel = _shopArr[row];
}


//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:FONT(16)];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)leftBtnAction {
    
    [self hide];
}



- (void)btnAction {
    
    [self hide];
    
    if(_successBlock != nil){
        
        _successBlock(_selModel);
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
