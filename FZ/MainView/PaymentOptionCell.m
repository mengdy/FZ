//
//  PaymentOptionCell.m
//  FZ
//
//  Created by mengdy on 16/10/21.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PaymentOptionCell.h"
#import "macro.h"


@implementation PaymentOptionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.optionName = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(10), 0, kViewWith(90), kViewHight(60))];
        _optionName.textColor = kSixWordColor;
        _optionName.font = [UIFont systemFontOfSize:14];
        self.optionTitle = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(110), 0, kScreenWith - kViewWith(150), kViewHight(60))];
        _optionTitle.textColor = kSixWordColor;
        _optionTitle.font = [UIFont systemFontOfSize:14];
        self.optionView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(35), kViewHight(18), kViewWith(25), kViewWith(25))];
        self.optionline = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(59.5), kScreenWith - kViewWith(20), 0.5)];
        _optionline.backgroundColor =klineViewColor;
        [self addSubview:_optionName];
        [self addSubview:_optionTitle];
        [self addSubview:_optionView];
        [self addSubview:_optionline];
        
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
