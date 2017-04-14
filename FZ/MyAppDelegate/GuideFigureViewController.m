//
//  GuideFigureViewController.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "GuideFigureViewController.h"
#import "AppDelegate.h"
#import "macro.h"
#import "BaseTabBarViewController.h"


@interface GuideFigureViewController ()<UIScrollViewDelegate,UITabBarControllerDelegate>

@end

@implementation GuideFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(kScreenWith * 4, 0);
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    for (int i = 1; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWith*(i - 1), 0, kScreenWith, kScreenHight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [_scrollView addSubview:imageView];
        
        if (i == 4) {
            
            imageView.userInteractionEnabled = YES;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30, kScreenHight - 100, kScreenWith - 60, 40)];
        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleRightNowExperience:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];

      }
    }
    _scrollView.bounces = NO;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //设置pageContrl
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(30, kScreenHight - 50, kScreenWith - 60, 30)];
    _pageControl.numberOfPages = 4;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(handleClickPage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    
}

//立即体验按钮
- (void)handleRightNowExperience : (UIButton *)button {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GuideFinshPicture object:nil];
}



-(void)handleClickPage:(UIPageControl *)sender{
    //在不同的分页数里对应不同的界面
    //通过当前页currentpage控制SCROllView的偏移量
    //self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * sender.currentPage, 0);
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width * sender.currentPage, 0) animated:YES];//带动画效果
//    NSLog(@"currentPage = %ld",sender.currentPage);
    
}

#pragma mark scroller--Delegate 
//触发时机：当scrolllView时图已经减速完成时触发（该方法不一定触发）***************
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //得到分页数的下标
    NSInteger index = scrollView.contentOffset.x/self.view.frame.size.width;
    //改变当前分页数
    self.pageControl.currentPage = index;
//    NSLog(@"当scrolllView时图已经减速完成时触发%s,%d",__FUNCTION__,__LINE__);
    
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
