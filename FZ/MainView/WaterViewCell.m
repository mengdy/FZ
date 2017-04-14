//
//  WaterViewCell.m
//  FZ
//
//  Created by mengdy on 16/10/25.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "WaterViewCell.h"
#import "macro.h"

@implementation WaterViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.waterTitle = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(15), 0, kViewWith(100), kViewHight(60))];
        _waterTitle.textColor = [UIColor blackColor];
        _waterTitle.font = [UIFont systemFontOfSize:14];
        _waterTitle.textAlignment = NSTextAlignmentLeft;
        self.waterText = [[UITextField alloc]initWithFrame:CGRectMake(kViewWith(120), 0, kScreenWith-kViewWith(50)- kViewWith(120), kViewHight(60))];
        _waterText.textColor = kSixWordColor;
        _waterText.font = [UIFont systemFontOfSize:14];
        
        UIImage *rightArrow = [UIImage imageNamed:@"rightArrow"];
        self.waterBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(40),(kViewHight(60) - rightArrow.size.height)/2.f, rightArrow.size.width, rightArrow.size.height)];
        [_waterBtn setBackgroundImage:rightArrow forState:UIControlStateNormal];
        _waterBtn.hidden = YES;
        
        self.waterLine = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(15), kViewHight(59), kScreenWith - kViewWith(30), 1)];
        _waterLine.backgroundColor = kCCLineBGColor;
    
        [self addSubview:_waterText];
        [self addSubview:_waterTitle];
        [self addSubview:_waterBtn];
        [self addSubview:_waterLine];
        
        
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
