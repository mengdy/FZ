//
//  ListCell.m
//  FZ
//
//  Created by mengdy on 16/12/2.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.listLbTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 48)];
        _listLbTitle.font = [UIFont systemFontOfSize:14];
        _listLbTitle.textColor = [UIColor blackColor];
        _listLbTitle.backgroundColor = [UIColor clearColor];
        
        self.listImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, 9, 30, 20)];
        _listImage.backgroundColor = [UIColor clearColor];
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 48, self.frame.size.width - 10, 0.5)];
        _lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:_listLbTitle];
        [self addSubview:_listImage];
        [self addSubview:_lineView];
    }
    
    return  self;
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
