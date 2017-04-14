//
//  PassWordCell.m
//  FZ
//
//  Created by mengdy on 16/10/17.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PassWordCell.h"
#import "macro.h"

@implementation PassWordCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(10), 0, kViewWith(90), kViewHight(60))];
        _nameLabel.textColor = kSixWordColor;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        self.passWordTextFiled = [[PassGuardTextField alloc]initWithFrame:CGRectMake(kViewWith(100), 0, kScreenWith - kViewWith(100), kViewHight(60))];
        [PassGuardTextField initPassGuardCtrl];
        [_passWordTextFiled setM_uiapp:[UIApplication sharedApplication]];
        _passWordTextFiled.m_ikeyordertype   = KEY_NONE_CHAOS;
        _passWordTextFiled.m_ikeypresstype   = KEY_IPHONE_KEY_PRESS;
        _passWordTextFiled.m_mode = NO;
        [_passWordTextFiled setM_license:KEYBOARD_LICENCE];
        [self addSubview:_nameLabel];
        [self addSubview:_passWordTextFiled];
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
