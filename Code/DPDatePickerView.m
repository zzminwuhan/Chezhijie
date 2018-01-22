//
//  DPDatePickerView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/31.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DPDatePickerView.h"

#import "NSDate+STCalendar.h"

@interface DPDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong)UIPickerView *pickerView;

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)NSMutableArray *yearArr;

@property (nonatomic ,strong)NSMutableArray *timeArr;

@property (nonatomic ,strong)NSMutableArray *time2Arr;

@property (nonatomic ,copy)DateSelBlock successBlock;

@property (nonatomic ,strong)NSString *selYear;
@property (nonatomic ,strong)NSString *selTime;
@property (nonatomic ,strong)NSString *selTime2;

@end


@implementation DPDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (void)showInView:(UIView*)view  success:(DateSelBlock)success {
    
    DPDatePickerView * popView = [[DPDatePickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.successBlock = success;
    [view addSubview:popView];
    
    
    [popView show];
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self initDate];
    
    [self creatView];
    
    return self;
}



- (void)initDate {
    
    
    NSDate * currentDate = [NSDate date];
    
    _yearArr = [NSMutableArray array];
    
    for(int i=0;i<100;i++){
        
        NSDate *date = [currentDate nextDateWithDay:i];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        [_yearArr addObject:strDate];
    }
    
    //    上午 9:00 - 11:00 \n  下午 13:30 - 16:30
    
    _timeArr = [NSMutableArray arrayWithArray:@[
                                                @"01时",@"02时",@"03时",@"04时",
                                                @"05时",@"06时",@"07时",@"08时",
                                                @"09时",@"10时",@"11时",@"12时",
                                                @"13时",@"14时",@"15时",@"16时",
                                                @"17时",@"18时",@"19时",@"20时",
                                                @"21时",@"22时",@"23时",@"00时"]];
    
    
    NSArray *arr = @[@"00分",@"01分",@"02分",@"03分",@"04分",@"05分",@"06分",@"07分",@"08分",@"09分",
                     @"10分",@"11分",@"12分",@"13分",@"14分",@"15分",@"16分",@"17分",@"18分",@"19分",
                     @"20分",@"21分",@"22分",@"23分",@"24分",@"25分",@"26分",@"27分",@"28分",@"29分",
                     @"30分",@"31分",@"32分",@"33分",@"34分",@"35分",@"36分",@"37分",@"38分",@"39分",
                     @"40分",@"41分",@"42分",@"43分",@"44分",@"45分",@"46分",@"47分",@"48分",@"49分",
                     @"50分",@"51分",@"52分",@"53分",@"54分",@"55分",@"56分",@"57分",@"58分",@"59分"];
    
    _time2Arr = [NSMutableArray arrayWithArray:arr];
    
    if(_yearArr.count > 0){
        _selYear = _yearArr[0];
    }
    
    _selTime = _timeArr[0];
    
    _selTime2 = _time2Arr[0];
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
    
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if(component == 0){
        
        return _yearArr.count;
    }
    else if(component == 1){
        
        return _timeArr.count;
    }
    else if(component == 2){
        
        return _time2Arr.count;
    }
    
    return 0;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    
    if(component == 0){
        
        return  _yearArr[row];
    }
    else if(component == 1){
        return _timeArr[row];
    }
    else if(component == 2){
        return _time2Arr[row];
    }
    
    return @"";
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(component == 0){
        self.selYear = _yearArr[row];
    }
    else if (component == 1){
        self.selTime = _timeArr[row];
    }
    else if (component == 2){
        self.selTime2 = _time2Arr[row];
    }
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
        
        NSString *date = [NSString stringWithFormat:@"%@ %@%@",_selYear,_selTime,_selTime2];
        _successBlock(date);
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
