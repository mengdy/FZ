//
//  MeAppDelegateViewController.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MeAppDelegateViewController.h"
#import "MoreApplicationListViewController.h"
#import "BusinessAnnouncementController.h"
#import "LORequestManger.h"
#import "MyApplactionCell.h"
#import "LoginViewController.h"

#import "PhonePayViewController.h"
#import "PayOilCardController.h"
#import "PayWaterRateViewController.h"
#import "PayElectricityController.h"
#import "PayFuelGasController.h"
#import "BSFingerSDK.h"

@interface MeAppDelegateViewController ()<XRCarouselViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BSFingerCallBack>


@end

@implementation MeAppDelegateViewController

- (NSMutableArray *)banaArrs {

    if (!_banaArrs) {
        self.banaArrs = [NSMutableArray arrayWithCapacity:2];
    }
    return _banaArrs;
}

- (NSMutableArray *)picUrlArrs {

    if (!_picUrlArrs) {
        self.picUrlArrs = [NSMutableArray arrayWithCapacity:1];
    }
    return _picUrlArrs;
}

- (NSMutableArray *)picDataSouseS{

    if (!_picDataSouseS) {
        self.picDataSouseS = [NSMutableArray arrayWithCapacity:2];
    }
    return _picDataSouseS;
}


////重写初始化方法
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    
//    NSLog( @"%s",__FUNCTION__);
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        //当创建该视图对象时，初始化方法就会被执行，如果此时访问该视图控制器的根视图view时，根视图view对象还不存在，所以，如果此时调用self.view，就会立刻执行loadView（加载视图的）方法以及ViewDidLoad（根视图加载完成）方法，不提倡在loadView方法前访问（使用）根视图view，这样会打乱系统自动调用方法的顺序
//               //自定义标签视图
//        UIImage * normalImage = [[UIImage imageNamed:@"myApp_normal"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage * selectImage = [[UIImage imageNamed:@"myApp_selected"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的应用" image:normalImage selectedImage:selectImage];
//        //添加标签视图
//        self.tabBarItem = tabBarItem;
//        //调整图标的位置 使用UITabBarItem父类中的继承到的属性 imageInsets （上 zuo 下 右）
//        tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabbarSelectColor} forState:UIControlStateSelected];
//        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabbarNormalColor} forState:UIControlStateNormal];
//    }
//    return self;
//    
//}

- (void)viewWillAppear:(BOOL)animated {

    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = klineViewColor;
    //iOS_7.0之后view被导航栏遮盖
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"统统付";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:kTabbarSelectColor}];
    
    self.dataSouseArrs = [NSMutableArray arrayWithObjects:@"手机充值",@"加油卡充值",@"水费缴费",@"电费缴费",@"燃气缴费",@"账户充值",@"账户转账",@"卡余额查询",@"更多", nil];
    self.picDataSouseS = [NSMutableArray arrayWithObjects:@"me1",@"me2",@"me3",@"me4",@"me5",@"me6",@"me7",@"me8",@"me20", nil];
    XMGLog(@"i9i9i9i9");
   
//    NSLog(@"%lu",(unsigned long)[_dataSouseArrs count]);
    
    //设置轮播图
    [self theBanaAbountFormat];
    //广告栏
    [self addAdvertisingLable];
    //设置网格内容样式
    [self scrollerViewOnGridView];
    
    
    [[BSFingerSDK sharedInstance] getFingerPrint:self withKey:@"123"];


}

//设置轮播图
- (void) theBanaAbountFormat {

    NSString *banaUrl = [NSString stringWithFormat:@"%@getBanners.do",URLS];
    NSMutableArray *picURLs = [NSMutableArray arrayWithCapacity:1];
    
    [LORequestManger GET:banaUrl success:^(id response) {
        
        _banaArrs = [response objectForKey:@"BANNERS"];
        for (int i = 0; i < _banaArrs.count; i ++) {
            NSDictionary *dic = [_banaArrs objectAtIndex:i];
            NSString *picUrl = [dic objectForKey:@"img"];
            [picURLs addObject:picUrl];
            [_picUrlArrs addObject:dic];
        }
        self.carouselView = [XRCarouselView carouselViewWithImageArray:picURLs describeArray:nil];
        self.carouselView.frame = CGRectMake(0, 0, kScreenWith, kViewHight(140));
        //用代理处理图片点击
        _carouselView.delegate = self;
        //设置每张图片的停留时间，默认值为5s，最少为2s
        _carouselView.time = 2;
        //设置分页控件的图片,不设置则为系统默认
        //  [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
        [_carouselView setPageColor:[UIColor whiteColor] andCurrentPageColor:[UIColor colorWithRed:57.f/255.f green:180.f/255.f blue:238.f/255.f alpha:1]];
        //设置分页控件的位置，默认为PositionBottomCenter
        _carouselView.pagePosition = PositionBottomCenter;
        
        /**
         *  修改图片描述控件的外观，不需要修改的传nil
         *  参数一 字体颜色，默认为白色
         *  参数二 字体，默认为13号字体
         *  参数三 背景颜色，默认为黑色半透明
         */
        UIColor *bgColor = [[UIColor clearColor] colorWithAlphaComponent:0];
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *textColor = [UIColor greenColor];
        [_carouselView setDescribeTextColor:textColor font:font bgColor:bgColor];
        if (picURLs.count == 1) {
            _carouselView.pageControl.numberOfPages = 0;
        }
        [self.view addSubview:_carouselView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.domain);
    }];
}
//公告栏
- (void)addAdvertisingLable
{
    
    _advertisingView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHight(140), kScreenWith, kViewHight(40))];
    _advertisingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_advertisingView];
    
    //
    UIImageView *noticeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, kViewHight(30))];
    noticeView.image = [UIImage imageNamed:@"notice"];
    [_advertisingView addSubview:noticeView];
    
    //
    UIView *verticalView = [[UIView alloc]initWithFrame:CGRectMake(80, 5, 1, kViewHight(30))];
    verticalView.backgroundColor = klineViewColor;
    [_advertisingView addSubview:verticalView];
    
    //公告栏
    _advertisinglabel = [[PaomaLabel alloc] initWithFrame:CGRectMake(90,10, kScreenWith - 130, kViewHight(20))];
    NSString *adevertisngUrl = [NSString stringWithFormat:@"%@getNotices.do?content={index:1, count:10}",URLS];
     _workingHelp = [BanaDataHelp shareBanaData];
    [_workingHelp getddWithUrlPath:adevertisngUrl params:nil callBack:^(NSDictionary *data) {
//        NSLog(@"Advertising title is %@",data);
        NSMutableArray *notices = [data objectForKey:@"NOTICES"];
        _noticeArrs = notices;
        
        NSDictionary *dic = [notices objectAtIndex:0];
        _advertisinglabel.text = [dic objectForKey:@"title"];
        
//        NSLog(@"advertisinglabel.text is %@",_advertisinglabel.text);
        
        _advertisinglabel.font = [UIFont systemFontOfSize:14];
        _advertisinglabel.textColor = [UIColor darkGrayColor];
        [_advertisingView addSubview:_advertisinglabel];
    }];

    UIImageView *moreDetailsView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWith - 40, 5, 30, kViewHight(30))];
    moreDetailsView.image = [UIImage imageNamed:@"notice_more"];
    moreDetailsView.userInteractionEnabled = YES;
    [_advertisingView addSubview:moreDetailsView];
    UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleClickMoreDetailsContent:)];
    [moreDetailsView addGestureRecognizer:tp];
 
}

- (void)scrollerViewOnGridView {

    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kViewHight(190), kScreenWith, kViewHight(109 * 3))];
    _scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollerView];
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
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(109*3)) collectionViewLayout:layout];
    //设置背景颜色
    collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collectionView registerClass:[MyApplactionCell class] forCellWithReuseIdentifier:@"item"];
    
    [_scrollerView addSubview:collectionView];

}

#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    NSDictionary *dic = [_picUrlArrs objectAtIndex:index];
    NSString *evenType = [dic objectForKey:@"eventType"];
    
  NSLog(@"点击的evenType is %@",evenType);
    if ([evenType isEqualToString:@"2"]) {
        NSLog(@"点击2类型跳转地图");
        
    }
    if ([evenType isEqualToString:@"1"]) {
        NSLog(@"点击了1类官网型");
       
    }
    if ([evenType isEqualToString:@"3"]) {
        NSLog(@"点击了3类型简介");
        
    }
    if ([evenType isEqualToString:@"0"]) {
        NSLog(@"点击0类型");
        return ;
    }
    
    
    NSLog(@"dic is %@",dic);
}

#pragma mark -- 更多详情页内容
- (void)handleClickMoreDetailsContent:(UITapGestureRecognizer *)tap {

    NSLog(@"更多详情页");
    BusinessAnnouncementController *announcement = [[BusinessAnnouncementController alloc]init];
    [self presentViewController:announcement animated:YES completion:^{
        
        
    }];
}

-(void)sureAction:(UIAlertController*)action{

    
    
    
    
}

-(void)cancleAction{
    NSLog(@"我的应用取消按钮");
}

-(void)pushLaunchPrompt{

    NSLog(@"我的应用刚刚推出提示框的时候!");
}

#pragma mark --- UICollectionView  delegate  V  dataSouce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataSouseArrs.count;
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
   
    if (_dataSouseArrs.count -1 == indexPath.row ) {
        cell.markImageView.image = [UIImage imageNamed:@"me20"];
        cell.markTitleLabel.text = @"更多";
        
    }
    cell.markTitleLabel.textColor = kSixWordColor;
    cell.markTitleLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *bgVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWith-3)/3.f,  kViewHight(108))];
    bgVeiw.backgroundColor = kBGViewColor;
    cell.selectedBackgroundView = bgVeiw;
    return cell;
}

//点击cell响应的事件的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //实现点击item时出现颜色
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 8) {
        MoreApplicationListViewController *appList = [[MoreApplicationListViewController alloc]init];
        [self .navigationController pushViewController:appList animated:YES];
    }else{
    
        if (indexPath.row == 0) {
            PhonePayViewController *phone = [[PhonePayViewController alloc]init];
            [self.navigationController pushViewController:phone animated:YES];
            
        }else{

            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin" ] isEqualToString:@"1"]) {
                
                LoginViewController *login = [[LoginViewController alloc]init];
                [self presentViewController:login animated:YES completion:nil];
            }else {
        
                if (indexPath.row == 1) {
                    PayOilCardController *oilCard = [[PayOilCardController alloc]init];
                    [self.navigationController pushViewController:oilCard animated:YES];
                }else if (indexPath.row == 2){
                    PayWaterRateViewController *waterRate = [[PayWaterRateViewController alloc]init];
                    [self.navigationController pushViewController:waterRate animated:YES];
                }else if (indexPath.row == 3){
                    PayElectricityController * electricity = [[PayElectricityController alloc]init];
                    [self.navigationController pushViewController:electricity animated:YES];
                }else if (indexPath.row == 4){
                    PayFuelGasController *fuelGas = [[PayFuelGasController alloc]init];
                    [self.navigationController pushViewController:fuelGas animated:YES];
                    
                }else if (indexPath.row == 5){
                    NSLog(@"账户充值");
                
                }else if (indexPath.row == 6){
                
                    NSLog(@"账户转账");
                }else if (indexPath.row == 7) {
                
                    NSLog(@"卡余额查询");
                }
             
            }
            
        }
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



/**
 * 设备指纹回调方法: 设备指纹生成成功
 *
 */
- (void)generateOnSuccess :(NSString *) fingerPrint andTraceId :(NSString *)traceId{

    NSLog(@"获取设备指纹成功 %@",fingerPrint);
}

/**
 * 设备指纹回调方法: 设备指纹生成失败
 *
 */
- (void)generateOnFailed :(NSError *) error{


    NSLog(@"获取设备指纹失败");
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
