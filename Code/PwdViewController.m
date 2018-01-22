//
//  PwdViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "PwdViewController.h"

#import "RBoxTextView.h"

#import "ICodeButton.h"

@interface PwdViewController ()

@property (nonatomic ,strong)RBoxTextView * phone ;
@property (nonatomic ,strong)RBoxTextView * password ;
@property (nonatomic ,strong)RBoxTextView * passwordA ;
@property (nonatomic ,strong)RBoxTextView * code ;


@property (nonatomic ,strong)UIScrollView * headView;

@end

@implementation PwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"找回密码"];
    
    [self initHeadView];
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




- (void)initHeadView {
    
    _headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    [self.view addSubview:_headView];
    
    _headView.backgroundColor = GRAYCOLOR;
    
    
//    UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85, 36)];
//    logo.image = [UIImage imageNamed:@"logo"];
//    logo.center = CGPointMake(SCREEM_WIDTH/2, 70);
//    [_headView addSubview:logo];
    
    CGFloat y = 10;
    
    _phone = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y, SCREEM_WIDTH, 44)];
    _phone.title.text = @"手机号码";
    _phone.textField.placeholder = @"请输入手机号码";
    [_headView addSubview:_phone];
    
    _code = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44, SCREEM_WIDTH, 44)];
    _code.title.text = @"验证码";
    _code.textField.placeholder = @"输入验证码";
    [_headView addSubview:_code];
    
    [_code setBottom];
    
    _password = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44*2+10, SCREEM_WIDTH, 44)];
    _password.title.text = @"密码";
    _password.textField.placeholder = @"请输入密码";
    [_headView addSubview:_password];
    
    
    
    _passwordA = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44*3+10, SCREEM_WIDTH, 44)];
    _passwordA.title.text = @"确定密码";
    _passwordA.textField.placeholder = @"请再次输入密码";
    [_headView addSubview:_passwordA];
    
    [_passwordA setBottom];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _passwordA.bottom + 94, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
    [btn addTarget:self action:@selector(logBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:btn];
    
    
    CGRect btnf = CGRectMake(SCREEM_WIDTH - 90, 9, 75, 26);
    ICodeButton* codeBtn = [[ICodeButton  alloc]initWithFrame:btnf];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:RGB(247, 124, 126) forState:UIControlStateNormal];
    codeBtn.titleLabel.font = FONT(11);
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 2;
    codeBtn.layer.borderWidth = 0.8;
    codeBtn.layer.borderColor = RGB(247, 124, 126).CGColor;
    [_code addSubview:codeBtn];
    
    [codeBtn addTarget:self action:@selector(codeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * hideBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 60, 0, 50, 44)];
    
    [hideBtn setImage:[UIImage imageNamed:@"pwd_hide"] forState:UIControlStateNormal];
    [hideBtn setImage:[UIImage imageNamed:@"pwd_hide"] forState:UIControlStateSelected];
    [_password addSubview:hideBtn];
    
    [hideBtn addTarget:self action:@selector(hideBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    CGFloat x = 15;
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, _passwordA.bottom , SCREEM_WIDTH - 2*x, 40)];
//    [btn3 setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateNormal];
//    
//    [btn3 setAttributedTitle:[self setTip] forState:UIControlStateNormal];
//    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
//    [btn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
//    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
//    [_headView addSubview:btn3];
}


- (void)codeBtnAction:(ICodeButton*)btn {
    
    NSLog(@"code btn ");
    
    NSString *url = HOSTAPIKEY(@"api/public/checkmember");
    
    NSString * loginname = _phone.textField.text;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:loginname forKey:@"mobile"];
    [parameters setObject:@"find" forKey:@"action"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        if([dict[@"res"] integerValue] == 1){
            
            
            [btn timeStart];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}



- (void)hideBtnAction:(UIButton*)btn {
    
    btn.selected = !btn.selected;
    if(btn.selected == YES){
        
        _password.textField.secureTextEntry = YES;
        _passwordA.textField.secureTextEntry = YES;
        
    }
    else {
        _password.textField.secureTextEntry = NO;
        _passwordA.textField.secureTextEntry = NO;
        
    }
    
}


- (NSAttributedString *)setTip {

    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:RGB(100, 100, 100)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:@"我已阅读同意" attributes:attributes1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"《用户协议及隐私权声明》" attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}


- (void)logBtnAction {
    
    if([_password.textField.text isEqualToString:_passwordA.textField.text] == NO){
        
        [HUDManager alertText:@"两次密码不一致"];
        return;
    }
    
    
    NSString *url = HOSTAPIKEY(@"api/public/findpwd");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * mobile = _phone.textField.text;
    NSString * newpwd  = _password.textField.text;
    NSString * code  = _code.textField.text;
    
    NSString * token = [UserManager getToken];
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:mobile forKey:@"mobile"];
    [parameters setObject:newpwd forKey:@"newpwd"];
    [parameters setObject:code forKey:@"code"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
    }];

}




@end
