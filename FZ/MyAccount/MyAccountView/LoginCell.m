//
//  LoginCell.m
//  FZ
//
//  Created by mengdy on 16/10/17.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "LoginCell.h"
#import "macro.h"

@implementation LoginCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(10), 0, kViewWith(90), kViewHight(60))];
        self.loginLabel.textColor = kSixWordColor;
        self.loginLabel.font = [UIFont systemFontOfSize:16];
        self.loginTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(kViewWith(100), 0,kScreenWith - kViewWith(100), kViewHight(60))];
        self.loginTextFiled.font = [UIFont systemFontOfSize:18];
        [self addSubview:_loginLabel];
        [self addSubview:_loginTextFiled];
        
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
