//
//  MoreSelectCell.m
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreSelectCell.h"

@implementation MoreSelectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.markImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 17, 25, 25)];
        self.markImageView.backgroundColor = [UIColor clearColor];
        _markImageView.userInteractionEnabled = YES;
        
        self.markTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 30, 30)];
        _markTitle.layer.cornerRadius = 15;
        _markTitle.layer.masksToBounds = YES;
        _markTitle.textAlignment = NSTextAlignmentCenter;
        _markTitle.layer.borderWidth = 1;
        _contactTitle.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor];
        _markTitle.textColor = [UIColor blackColor];
        _markTitle.font = [UIFont systemFontOfSize:18];
        
        
        self.contactTitle = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, kScreenWith - 20, 30)];
        _contactTitle.backgroundColor = [UIColor clearColor];
        _contactTitle.font = [UIFont systemFontOfSize:14];
        _contactTitle.textColor = [UIColor blackColor];
        
        self.addressTitle = [[UILabel alloc]initWithFrame:CGRectMake(65, 30, kScreenWith - 20, 30)];
        _addressTitle.backgroundColor = [UIColor clearColor];
        _addressTitle.font = [UIFont systemFontOfSize:14];
        _addressTitle.textColor = [UIColor blackColor];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWith, 0.5)];
        self.lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        [self addSubview:_markImageView];
        [self addSubview:_markTitle];
        [self addSubview:_contactTitle];
        [self addSubview:_addressTitle];
        [self addSubview:_lineView];
        
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
