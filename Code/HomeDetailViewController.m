//
//  HomeDetailViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeDetailViewController.h"

#import <WebKit/WebKit.h>

@interface HomeDetailViewController ()<WKNavigationDelegate>

@property (nonatomic,strong)UILabel *progress;

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)WKWebView *webView;

@property (nonatomic,strong)NSString *url;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"详情"];
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    [self initWebView];
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




- (void)initWebView {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    label.text = @"网页由";
    [self.view addSubview:label];
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    //    [_webView setOpaque:NO];
    
    
    NSString *url = _model.url;
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [_webView loadRequest:request];
    
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    _progress = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 2)];
    _progress.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_progress];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    // 禁止放大缩小
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
}



- (void)dealloc {
    
    
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary* )change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
    } else if ([keyPath isEqualToString:@"title"]) {
        //        self.title = self.wKWebView.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        //        self.progressView.progress = self.wKWebView.estimatedProgress;
    }
    
    if ( [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            _progress.hidden = YES;
            _progress.frame = CGRectMake(0, 0, 0, 2);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }else {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                _progress.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) * newprogress, 2);
            }];
        }
        
        NSLog(@"%@",@(newprogress));
        
        
        
    }
}





@end
