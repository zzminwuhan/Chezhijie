//
//  BootPageViewController.m
//  TongHuaLi
//
//  Created by 李加建 on 2017/9/30.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "BootPageViewController.h"

@interface BootPageViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView * scrollView;
@property(strong,nonatomic)UIPageControl * pageControl;
@property(assign,nonatomic)NSInteger count;


@end

@implementation BootPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatScrollview];
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



- (void)creatScrollview {
    
    _count = 3;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(SCREEM_WIDTH*_count, SCREEM_HEIGHT);
    _scrollView.pagingEnabled =YES;
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    
    for(int i=0;i<_count;i++)
    {
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH*i, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
        NSString *pathname = [NSString stringWithFormat:@"0%d.png",i+1];
        
        [image setImage:[UIImage imageNamed:pathname]];
        
        if(i==(_count-1)) {
            
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction)];
            [image addGestureRecognizer:tap];
        }
        [_scrollView addSubview:image];
    }
    

    
    [self.view addSubview:_scrollView];
}



- (void)loadpageControl {
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT*0.93, SCREEM_WIDTH, 20)];
    _pageControl.numberOfPages = _count;
    _pageControl.currentPage =0;
    //    UIImage * pre= [UIImage imageNamed:@"uikit_page_normal"];
    //    UIImage * pre1= [UIImage imageNamed:@"star"];
    _pageControl.pageIndicatorTintColor =  [UIColor lightGrayColor];//[UIColor colorWithPatternImage:pre];
    _pageControl.currentPageIndicatorTintColor = MAINCOLOR;//[UIColor colorWithPatternImage:pre1];
    [self.view addSubview:_pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = floor(_scrollView.contentOffset.x/SCREEM_WIDTH+0.5);
    _pageControl.currentPage = page;
}



- (void)btnAction {
    
    if(_goBlock != nil){
        _goBlock();
    }
}




@end
