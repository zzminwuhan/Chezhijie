//
//  TipViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *label;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPresentBarBtn:self.tipTitle];
    
    [self setLeftBarWithCustomView:nil];
    
    [self creatView];
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



- (void)creatView {
    
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 40, 40, 80, 80)];
    
    _imgView.image = [UIImage imageNamed:@"tipvc"];
    
    [self.view addSubview:_imgView];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom+5, SCREEM_WIDTH, 80)];

    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 3;

    [self.view addSubview:_label];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, _label.bottom + 50, SCREEM_WIDTH - 40, 44)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    btn.backgroundColor = MAINCOLOR;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [self setAttr];
}




- (void)setAttr {
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距

    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:GRAY50,NSFontAttributeName:FONT18,NSParagraphStyleAttributeName:paragraphStyle};
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:RGB(250, 117, 120),NSFontAttributeName:FONT10,NSParagraphStyleAttributeName:paragraphStyle};
    
    NSString *attstr = [NSString stringWithFormat:@"%@\n%@",self.tipText,self.tipDetail];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:attstr];
    
    
    [attriString setAttributes:attributes2 range:NSMakeRange(0, attriString.length)];
    [attriString setAttributes:attributes range:NSMakeRange(0, self.tipText.length)];
    
    _label.attributedText = attriString;
    
    _label.textAlignment = NSTextAlignmentCenter;
}





- (void)btnAction {
    
    
    UITabBarController * tabBar = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIBaseNavigationController *navi = tabBar.viewControllers[0];
    
    [navi popToRootViewControllerAnimated:NO];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
