//
//  ShopQueryViewController.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "ShopQueryViewController.h"
#import "macro.h"
#import "MyApplactionCell.h"
#import "AppListModel.h"
#import "ShopListViewController.h"
#import "SearchViewController.h"
#import "UserViewController.h"
#import "ContactController.h"
#import "SelectMoreController.h"


@interface ShopQueryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>


@property (nonatomic,strong)UITextField *searchText;
@property (nonatomic,strong)UITapGestureRecognizer *tap;

@end

@implementation ShopQueryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    [self addSearchView];
    
}

-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //iOS_7.0之后view被导航栏遮盖
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = kBGViewColor;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.allKeys = [NSMutableArray array];
    
     [self collectionShopQueryModel];
    //创建点击视图
    [self scrollerViewOnGridView];
    //添加伪搜索栏
        [self addSearchView];
    UIImage *positionImage = [UIImage imageNamed:@"mapIcon_2"];
    
    UIButton *positionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, positionImage.size.width, positionImage.size.height)];
    [positionBtn setBackgroundImage:positionImage forState:UIControlStateNormal];
    [positionBtn addTarget:self action:@selector(positionEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:positionBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#define  mark -- 添加伪搜索栏
- (void)addSearchView{

    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(kViewWith(80), kViewHight(30),kScreenWith -kViewWith(160), kViewHight(30))];
    _searchText.placeholder = @"搜索";
    _searchText.backgroundColor = [UIColor whiteColor];
    _searchText.layer.cornerRadius = 10;
    _searchText.layer.masksToBounds = YES;
    _searchText.enabled = NO;
    _searchText.borderStyle = UITextBorderStyleNone;
    _searchText.layer.borderWidth = 0.5;
    _searchText.userInteractionEnabled = YES;
    _searchText.layer.borderColor = kTabbarNormalColor.CGColor;
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    _searchText.leftView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"search"]];
    _searchText.textAlignment = NSTextAlignmentCenter;
    _searchText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //解决占位符不居中的问题 以及颜色设定
    NSMutableParagraphStyle *style = [_searchText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = _searchText.font.lineHeight - (_searchText.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    _searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索"attributes:@{NSForegroundColorAttributeName: kTabbarNormalColor,NSFontAttributeName : [UIFont systemFontOfSize:14.0],NSParagraphStyleAttributeName : style}];
    self.navigationItem.titleView = _searchText;
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNeedThing:)];
    _tap.delegate = self;
    [_searchText addGestureRecognizer:_tap];
    
}


//搜索栏点击事件
-(void)searchNeedThing:(UITapGestureRecognizer *)tap {

    self.tabBarController.tabBar.hidden = YES;
    SearchViewController *seach = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:seach animated:YES];
}
#pragma mark UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    
//    if ([touch.view isKindOfClass:[UITextField class]]) {
//        //放过button点击拦截
//        return NO;
//    }else{
//        return YES;
//    }
//    
//}



#pragma 导航栏右侧按钮事件
- (void)positionEvent:(UIButton *)position {


    NSLog(@"定位");

}

#define   添加点击视图

-(void)collectionShopQueryModel {

    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"ShopQueryList" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    NSArray *items = [dic objectForKey:@"shopItems"];
    
    for (id dic in items) {
        
        AppListModel *model = [[AppListModel alloc]initWithDictionary:dic];
        [_allKeys addObject:model];
    }
}


- (void)scrollerViewOnGridView {
    
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
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(109*4)) collectionViewLayout:layout];
    //设置背景颜色
    collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collectionView registerClass:[MyApplactionCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.view addSubview:collectionView];
    
}

#pragma mark --- UICollectionView  delegate  V  dataSouce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _allKeys.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyApplactionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    AppListModel *model = [_allKeys objectAtIndex:indexPath.row];
    
    cell.markImageView.image = [UIImage imageNamed:model.iconName];
    cell.markTitleLabel.text = model.name;
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
    NSLog(@"第%ld区，第%ld行",(long)indexPath.section,(long)indexPath.row);
    self.tabBarController.tabBar.hidden = YES;
    if (indexPath.row == 0) {
        
        ShopListViewController *shop = [[ShopListViewController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }else if (indexPath.row == 1){
    
        UserViewController *user = [[UserViewController alloc]init];
        [self.navigationController pushViewController:user animated:YES];
    }else if (indexPath.row == 2){
    
        SelectMoreController *user = [[SelectMoreController alloc]init];
        [self.navigationController pushViewController:user animated:YES];

    }
    
    
    
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
