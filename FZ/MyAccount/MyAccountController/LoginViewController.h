//
//  LoginViewController.h
//  FZ
//
//  Created by mengdy on 16/10/14.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 登录页面回调block */
typedef void(^presentBlock)();
@interface LoginViewController : UIViewController

@property (nonatomic,strong)UITabBarController *tabBar;
/** block属性 */
@property (nonatomic, copy) presentBlock presentBlock;

+ (void)doTaskAfterLoginFromController:(UIViewController *)fromVC afterLoginBlock:(presentBlock)presentBlock;

@end
