//
//  PaymentDetailsCell.m
//  FZ
//
//  Created by mengdy on 16/10/21.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PaymentDetailsCell.h"
#import "macro.h"

@implementation PaymentDetailsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.detailsName = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(10), 0, kViewWith(90), kViewHight(60))];
        _detailsName.textColor = kSixWordColor;
        _detailsName.font = [UIFont systemFontOfSize:14];
        self.detailsTitle = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(110), 0, kScreenWith - kViewWith(150), kViewHight(60))];
        _detailsTitle.textColor = kSixWordColor;
        _detailsTitle.font = [UIFont systemFontOfSize:14];
        self.detailsView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(35), kViewHight(18), kViewWith(25), kViewWith(25))];
        self.detailine = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(59.5), kScreenWith - kViewWith(20), 0.5)];
        _detailine.backgroundColor =klineViewColor;
        [self addSubview:_detailsName];
        [self addSubview:_detailsTitle];
        [self addSubview:_detailsView];
        [self addSubview:_detailine];
        
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
