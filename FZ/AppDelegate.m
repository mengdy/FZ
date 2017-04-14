//
//  AppDelegate.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"

#import "GuideFigureViewController.h"

#import "AFNetworkReachabilityManager.h"//af 里面监听网络状态
#import "FileManager.h"//单利模型，用来记录当前的网络状态


#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建window
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  [[UIButton appearance] setExclusiveTouch:YES];
//   [UIView setAnimationDuration:5.0];
    
        BaseTabBarViewController  *tb = [[BaseTabBarViewController alloc]init];
        self.window.rootViewController = tb;
    
    //调用网络状态
    [AppDelegate netWorkStatus];
    
    return YES;
}

//
+(void)netWorkStatus {

    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 数据 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */

    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //这是单利＋模型，用来记录网络状态
        FileManager *maa = [FileManager shareFileManager];
        maa.netState = status;
        NSLog(@"-----网络状态----%ld---%d", status,maa.netState);
        
        
        if (status == 1) {
            
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"666666");
        }];
        [alert addAction:action];
        
        AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [ap.window.rootViewController presentViewController:alert animated:YES completion:^{
            
        }];
        }
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
