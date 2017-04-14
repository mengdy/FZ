//
//  ShopListViewController.m
//  FZ
//
//  Created by mengdy on 16/10/18.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "ShopListViewController.h"
#import "macro.h"

static NSIndexPath *path = nil;

@interface ShopListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *barImageView;


@property (nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation ShopListViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tableView) {
        self.tableView.delegate = self;
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    
    //因为navigation公用的  所以为了使其不收影响 需要进行下面操作
    [self.navigationController setValue:[UINavigationBar new]  forKey:@"navigationBar" ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商户列表";
    selectedIndexes = [[NSMutableDictionary alloc] init];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHight)];
    _tableView.backgroundColor = kBGViewColor;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self backView];

    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:_leftSwipeGestureRecognizer];
    [self.tableView addGestureRecognizer:_rightSwipeGestureRecognizer];
    
    
    
    
}


- (void)backView {
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(handleBackView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

// 返回按钮事件
- (void)handleBackView : (UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#define mark ---  delegate  dateSouce;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self cellIsSelected:indexPath]) {
        return 100;
    }
    return 50;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //添加此方法即可完成 松开cell之后cell回复原来的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"第%ld行,",(long)indexPath.row);
    
    [selectedIndexes removeAllObjects];
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:indexPath];
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView reloadData];
}

//设置cell点击会变化
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    
    NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
    
}


//tableVeiw在滑动的过程中  导航栏发生颜色变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //只是设置这两行  导航栏全透明状态
    /*
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    */
    //导航栏颜色渐渐变换
    /*
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor redColor] colorWithAlphaComponent:alpha ]] forBarMetrics:UIBarMetricsDefault];
     */
    
    //导航栏突然变色
    /*
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    if (alpha >= 0.8) {
        
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    }else {
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor redColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    
    }
    */
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
}


-(void)handleSwipes : (UISwipeGestureRecognizer *)gesture{

    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"这是向左活动");
    }else if (gesture.direction == UISwipeGestureRecognizerDirectionRight){
    
        NSLog(@"向右滑动");
    }

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

@end
