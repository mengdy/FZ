//
//  MeAppDelegateViewController.h
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "macro.h"
#import "XRCarouselView.h"
#import "PaomaLabel.h"
#import "BanaDataHelp.h"


@interface MeAppDelegateViewController : UIViewController

@property (nonatomic, strong) XRCarouselView *carouselView;
@property (nonatomic,strong)NSMutableArray *banaArrs;//轮播图的个数
@property (nonatomic,strong)NSMutableArray *picUrlArrs;//轮播图图片显示地址

@property (nonatomic,strong) PaomaLabel *advertisinglabel;//跑马灯
@property (strong, nonatomic) UIView *advertisingView;
@property (nonatomic,strong) NSMutableArray *noticeArrs;

@property (nonatomic,strong)BanaDataHelp *workingHelp;
@property (nonatomic,strong)UIScrollView *scrollerView;
@property (nonatomic,strong)NSMutableArray *dataSouseArrs;
@property (nonatomic,strong)NSMutableArray *picDataSouseS;



@end
