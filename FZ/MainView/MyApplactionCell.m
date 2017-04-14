//
//  MyApplactionCell.m
//  FZ
//
//  Created by mengdy on 16/10/1.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MyApplactionCell.h"
#import "macro.h"


@implementation MyApplactionCell


-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame: frame];
    if (self) {
        
        self.markImageView = [[UIImageView alloc]initWithFrame:CGRectMake(((kScreenWith-3)/3.f - 40)/2.f, kViewHight(23), kViewHight(40), kViewHight(40))];
        _markImageView.userInteractionEnabled = YES;
        [self addSubview:_markImageView];
        
        self.markTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kViewHight(68), (kScreenWith - 3)/3.f, kViewHight(30))];
        _markTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_markTitleLabel];
        
    }

    return self;
}

//-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    self.backgroundColor = [UIColor redColor];
//
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    self.backgroundColor = [UIColor whiteColor];
//
//}
//
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    self.backgroundColor = [UIColor whiteColor];
//}


@end
