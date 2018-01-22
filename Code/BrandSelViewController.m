//
//  BrandSelViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BrandSelViewController.h"

#import "BrandModel.h"

#import "BrandView.h"

@interface BrandSelViewController ()<UITableViewDelegate,UITableViewDataSource  >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;

@property (nonatomic,strong)NSArray* indexArray;
@property (nonatomic,strong)NSMutableArray* dataSource;
@property (nonatomic,strong)NSMutableArray* selArray;

@property (nonatomic,strong)BrandView * brandView;

@end

@implementation BrandSelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"品牌"];
    

    
    self.dataSource = [NSMutableArray array];
    self.selArray = [NSMutableArray array];
    
    [self initData];
    
    [self initTableView];
    
    [self loadData];
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


- (BrandView *)brandView {
    
    if(_brandView == nil){
        
        _brandView = [[BrandView alloc]initWithFrame:CGRectMake(-SCREEM_WIDTH, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
        
        _brandView.hidden = YES;
        [self.view addSubview:_brandView];
        
        __weak typeof(self) weak = self;
        _brandView.selModel = ^(BrandModel *model) {

            weak.model = model;
            if(weak.selBrandBlock != nil){
                weak.selBrandBlock(weak.brandModel , weak.model);
            }
            
            [weak.navigationController popViewControllerAnimated:YES];
        };
        
        
    }
    return _brandView;
}



- (void)showBrandView:(NSMutableArray *)array {
    
    [self.brandView setDataSource:array];
    self.brandView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.brandView.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64) ;
    } completion:^(BOOL finished) {
        
    }];
    
}



- (void)initData {
    
    _indexArray = @[@"A",@"B",@"C",@"D",@"E",@"F",
                    @"G",@"H",@"I",@"J",@"K",@"K",
                    @"M",@"N",@"O",@"P",@"Q",@"R",
                    @"S",@"T",@"U",@"V",@"W",@"X",
                    @"Y",@"Z",@"#"];
    
    
    for(int i=0;i<_indexArray.count;i++){
        
        NSMutableArray *array = [NSMutableArray array];
        
        [_dataSource addObject:array];
    }
    
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 50)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
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
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
//    _tableView.separatorStyle = NO;
    
    _tableView.sectionIndexColor = RGB(150, 150, 150);
}


- (void)headRefreshing {
    
//    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
//    [self loadData];
    
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
//    [self loadData];
}


//返回索引数组
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    
    return index;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_dataSource.count <= 0){
        return 0;
    }
    
    NSMutableArray *array = _dataSource[section];
    
    return array.count;
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
    
    NSMutableArray *array = _dataSource[indexPath.section];
    
    BrandModel * model = array[indexPath.row];

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
    
    if(_dataSource.count <= 0){
        return ;
    }
    
    NSMutableArray *array = _dataSource[indexPath.section];
    
    BrandModel * model = array[indexPath.row];
    
    _brandModel = model;
    
    [self selArrayWithModel:model];
   
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    
    view.backgroundColor = RGB(230, 230, 230);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, view.height)];
    label.font = FONT14;
    [view addSubview:label];
    
    if(_dataSource.count <= 0){
        return view;
    }
    
    label.text = _indexArray[section];
    
    NSMutableArray *array = _dataSource[section];
    
    if(array.count <= 0){
        return nil;
    }
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if(_dataSource.count <= 0){
        
        return 40;
    }
    
    
    NSMutableArray *array = _dataSource[section];
    
    if(array.count <= 0){
        return 0.01;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}





- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/getbrandlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSInteger pageCount = 9999;
    NSInteger maxCount = 0;//_dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [parameters setObject:@"0" forKey:@"parentid"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
//        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            NSArray *array = dict[@"elements"];
            
            for(NSDictionary *dic1 in array){
                
                BrandModel *model = [[BrandModel alloc]initWithDict:dic1];
                
//                [_dataSource addObject:model];
                
                NSString *word = [self firstCharactorWithString:model.name];
                
                model.firstWord = word;
                
                NSLog(@"word = %@",word);
                
                [self dataAddModel:model];
                
            }
            
            [_tableView reloadData];
            
            [RefleshManager tableView:_tableView count:array.count maxCount:pageCount];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}


- (void)dataAddModel:(BrandModel *)model {
    
    if(_dataSource.count <= 0){
        
        return;
    }
    
    
    NSString *wordB = model.firstWord;
    
    int asciiCode = [wordB characterAtIndex:0] - 65;
    
    
    if(asciiCode >=0 && asciiCode <= (90 - 65) ){
        
        NSMutableArray *array = _dataSource[asciiCode];
        
        [array addObject:model];
    }
    else {
        NSMutableArray *array = _dataSource[26];
        
        [array addObject:model];
    }
    
    
}




- (NSString *)firstCharactorWithString:(NSString *)string {
    
    if(string.length >0){
        
        NSString *first = [string substringToIndex:1];//字符串开始
        
        if([first isEqualToString:@"长"]==YES){
            
            return @"C";
        }
    }
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    
    return [pinYin substringToIndex:1];
}


- (void)selArrayWithModel:(BrandModel*)model {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/getbrandlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSInteger pageCount = 9999;
    NSInteger maxCount = 0; //self.dataSource;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    [parameters setObject:model.Id forKey:@"parentid"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            [self.selArray removeAllObjects];
            
            for(NSDictionary *dic1 in array){
                
                BrandModel *model = [[BrandModel alloc]initWithDict:dic1];
                
                [self.selArray addObject:model];
            }
            
            
            [self.brandView setAttr:model.name];
            
            [self showBrandView:self.selArray];
            
            [RefleshManager tableView:_tableView count:array.count maxCount:pageCount];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
    }];

}



@end
