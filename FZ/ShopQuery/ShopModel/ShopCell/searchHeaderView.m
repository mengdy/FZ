//
//  searchHeaderView.m
//  ShouYi
//
//  Created by yrapp on 16/2/23.
//  Copyright © 2016年 yurui. All rights reserved.
//

#import "searchHeaderView.h"
#import "macro.h"

@implementation searchHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
 
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.frame = CGRectMake(kScreenWith - kViewWith(50), kViewHight(33), kViewWith(50),20);
        _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_backButton setTitleColor:kTabbarSelectColor forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, kViewHight(30),kScreenWith - 40 - 40, 30)];
        [_searchBar setPlaceholder:@"搜索"];
        UIImageView *imageSearch = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_share_large"]];
        
        [self.searchBar insertSubview:imageSearch atIndex:1];
        self.searchBar.layer.masksToBounds = YES;
        self.searchBar.layer.cornerRadius = 5;
        // [self.searchBar setBarStyle:UIBarStyleDefault];
        self.searchBar.backgroundColor = [UIColor clearColor];
        [self addSubview:_searchBar];
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
