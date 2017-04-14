//
//  MoreSetTableViewCell.m
//  FZ
//
//  Created by mengdy on 16/10/14.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreSetTableViewCell.h"
#import "macro.h"


@implementation MoreSetTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:
             reuseIdentifier];
    if (self) {
        
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewWith(10), kViewWith(30), kViewWith(30))];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(50), kViewWith(10), kViewWith(120), kViewHight(30))];
        self.arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(40), kViewWith(10), kViewWith(30), kViewWith(30))];
        
        self.separatorView = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(49), kScreenWith - kViewWith(10)*2, 1)];
        _separatorView.backgroundColor = klineViewColor;
        
        [self addSubview:_iconImage];
        [self addSubview:_titleLabel];
        [self addSubview:_arrowImage];
        [self addSubview:_separatorView];
    }
    return self;
}










- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
