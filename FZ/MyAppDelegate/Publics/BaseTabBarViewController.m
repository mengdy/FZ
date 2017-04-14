//
//  BaseTabBarViewController.m
//  FZ
//
//  Created by mengdy on 16/9/30.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "BaseTabBarViewController.h"

#import "MeAppDelegateViewController.h"
#import "ShopQueryViewController.h"
#import "MyAccountViewController.h"
#import "MoreViewController.h"
#import "GuideFigureViewController.h"
#import "LoginViewController.h"


@interface BaseTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong)GuideFigureViewController *guideView;

@end

@implementation BaseTabBarViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(guidePictureFinished) name:GuideFinshPicture object:nil];
    if ([self isFirstInstall]) {
        self.guideView = [[GuideFigureViewController alloc]init];
        [self.view addSubview:self.guideView.view];
        
    }
    
    [self configureTabBar];
}


- (void)configureTabBar
{


    //创建子控制器
    //创建第一个导航视图控制器管理的根视图控制器
    MeAppDelegateViewController *me = [[MeAppDelegateViewController alloc]init];
    //创建第一个导航视图控制器对象，用来管理me
    ShopQueryViewController *sv = [[ShopQueryViewController alloc]init];
    MyAccountViewController *mv = [[MyAccountViewController alloc]init];
    //设置导航栏的背景颜色
    MoreViewController *more = [[MoreViewController alloc]init];
    
    NSMutableArray *vcArray = [NSMutableArray arrayWithObjects:me,sv,mv,more, nil];
    NSArray *titles  = @[@"我的应用",@"账户查询",@"我的账户",@"更多"];
    NSArray *norPics = @[@"myApp_normal",@"shops_normal",@"myAccount_normal",@"more_normal"];
    NSArray *selPics = @[@"myApp_selected",@"shops_selected",@"myAccount_selected",@"more_selected"];
    
    for (int i = 0; i < vcArray.count; i ++) {
        
        UIViewController *vc = vcArray[i];
        vc.title = titles[i];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [nc.tabBarItem setImage:[[UIImage imageNamed:norPics[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [nc.tabBarItem setSelectedImage:[[UIImage imageNamed:selPics[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [nc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabbarSelectColor} forState:UIControlStateSelected];
        [nc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabbarNormalColor} forState:UIControlStateNormal];
        //        [nc.tabBarItem  setTitle:@"我的世界"];
        [vcArray replaceObjectAtIndex:i withObject:nc];
        
    }
    //初始化一个tabbar
    //设置控制器为window的跟视图控制器
    //    self.window.rootViewController = tb;
    //给tabbar添加视图控制器（导航控制器）
    self.viewControllers = vcArray;
    //改变tabbar上的渲染颜色
    //    tb.tabBar.tintColor = [UIColor redColor];
    //改变tabbar的自身颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    //给tabbar添加背景图片  tabbar的默认告诉是49
    //    tb.tabBar.backgroundImage = [UIImage imageNamed:@""];
    //设置tabbar的默认选择item  默认是0
    self.selectedIndex = 0;

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"1234567");
    NSLog(@"当前tabBar的下表 : %lu",(unsigned long)tabBarController.selectedIndex);
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
     if ([viewController isKindOfClass:[UINavigationController class]]) {
    if (![isLogin isEqualToString:@"1"]) {
       UIViewController *vc = ((UINavigationController *)viewController).childViewControllers.firstObject;
        if ([vc isKindOfClass:[MyAccountViewController class]]) {
            __weak typeof (tabBarController)weakObj = self;
            [LoginViewController doTaskAfterLoginFromController:weakObj afterLoginBlock:^{
                
                NSLog(@"去登陆吧！");
            }];
            return NO;
        }
    }
  }
    return YES;
}

- (BOOL)isFirstInstall{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *install = [def objectForKey:@"APPVERSION"];
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([install isEqualToString:nowVersion]) {
        return NO;
    }else{
        [def setObject:nowVersion forKey:@"APPVERSION"];
        [def synchronize];
        return YES;
    }
}
#pragma mark -引导页完成
- (void)guidePictureFinished
{
    [UIView animateWithDuration:1 animations:^{
        self.guideView.view.alpha = 0;
    } completion:^(BOOL finished) {
        NSLog(@"finished: %d",finished);
        self.guideView = nil;
    }];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:GuideFinshPicture object:nil];
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
