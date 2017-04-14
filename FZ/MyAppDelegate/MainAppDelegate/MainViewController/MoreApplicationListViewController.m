//
//  MoreApplicationListViewController.m
//  FZ
//
//  Created by mengdy on 16/10/13.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreApplicationListViewController.h"

#import "macro.h"
#import "MyApplactionCell.h"
#import "AppListModel.h"

@interface MoreApplicationListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation MoreApplicationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"应用列表";
    self.view.backgroundColor = klineViewColor;
    self.tabBarController.tabBar.hidden = YES;

    self.dataSouseArrs = [NSMutableArray arrayWithObjects:@"手机充值",@"加油卡充值",@"水费缴费",@"电费缴费",@"燃气缴费",@"账户充值",@"账户转账",@"卡余额查询",@"卡密码修改",@"卡明细查询",@"商户收藏", nil];
    self.picDataSouseS = [NSMutableArray arrayWithObjects:@"me1",@"me2",@"me3",@"me4",@"me5",@"me6",@"me7",@"me8",@"me9",@"me10",@"me11", nil];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(handleBackView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小
    layout.itemSize = CGSizeMake((kScreenWith-3)/3, kViewHight(108));
    //设置分区的缩进量  控制item的位置  向上下左右平移
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //设置最小行距
    layout.minimumLineSpacing = 1;
    //设置最小item之间的距离
    layout.minimumInteritemSpacing = 1;
    //实现item之间的最小距离
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //7. 设置页眉的大小  区头
    //    layout.headerReferenceSize = CGSizeMake(0, 30);
    //8. 设置页脚的大小
    //    layout.footerReferenceSize = CGSizeMake(0, 40);
    
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHight - 64) collectionViewLayout:layout];
    //设置背景颜色
    collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collectionView registerClass:[MyApplactionCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.view addSubview:collectionView];

}

// 返回按钮事件
- (void)handleBackView : (UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark --- UICollectionView  delegate  V  dataSouce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.picDataSouseS.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyApplactionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.markImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_picDataSouseS[indexPath.row]]];
    cell.markTitleLabel.text = [NSString stringWithFormat:@"%@",_dataSouseArrs[indexPath.row]];
    
    cell.markTitleLabel.textColor = kSixWordColor;
    cell.markTitleLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *bgVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWith-3)/3.f,  kViewHight(108))];
    bgVeiw.backgroundColor = kBGViewColor;
    cell.selectedBackgroundView = bgVeiw;
    return cell;
}

//点击cell响应的事件的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"第%ld区，第%ld行",indexPath.section,indexPath.row);
    
    
    
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    [cell setBackgroundColor:klineViewColor];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    [cell setBackgroundColor:[UIColor whiteColor]];
}



- (void)viewDidDisappear:(BOOL)animated {

    self.tabBarController.tabBar.hidden = NO;

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
