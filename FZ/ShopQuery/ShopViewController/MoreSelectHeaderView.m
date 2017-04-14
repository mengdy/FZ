//
//  MoreSelectHeaderView.m
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreSelectHeaderView.h"

@implementation MoreSelectHeaderView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //加载控件
        [self.contentView addSubview:self.indictorImageView];
        [self.contentView addSubview:self.sectionTitleLabel];
        [self.contentView addSubview:self.contactNumberLabel];
    
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(respondsToTapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark   Gestures
-(void)respondsToTapGesture:(UITapGestureRecognizer *)gestures {
    
        [_delegate moreSelectHeadView:self didSelectedWithTag:self.tag];
}

-(UIImageView *)indictorImageView{

    if (!_indictorImageView) {
        _indictorImageView = [[UIImageView alloc]init];
        _indictorImageView.bounds = CGRectMake(0, 0, 20, 20);
        _indictorImageView.center = CGPointMake(15, 22);
        
    }
    return _indictorImageView;
}

-(UILabel *)sectionTitleLabel{

    if (!_sectionTitleLabel) {
        
        _sectionTitleLabel = [[UILabel alloc]init];
        _sectionTitleLabel.bounds = CGRectMake(0, 0, 150, 30) ;
        _sectionTitleLabel.center = CGPointMake(CGRectGetMaxX(self.indictorImageView.frame) + CGRectGetMidX(_sectionTitleLabel.bounds) + 10, 22);
        _sectionTitleLabel.font = [UIFont systemFontOfSize:18];
    }

    return _sectionTitleLabel;
}

-(UILabel *)contactNumberLabel{

    if (!_contactNumberLabel) {
        
        _contactNumberLabel = [[UILabel alloc]init];
        _contactNumberLabel.font = [UIFont systemFontOfSize:16];
        _contactNumberLabel.frame = CGRectMake(kScreenWith - 50, 5, 30, 30);
    
    }
    return _contactNumberLabel;
}





@end
