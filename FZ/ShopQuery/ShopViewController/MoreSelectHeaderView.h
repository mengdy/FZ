//
//  MoreSelectHeaderView.h
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "macro.h"


@class MoreSelectHeaderView;

//协议声明
@protocol MoreSelectHeaderViewDelegate <NSObject>

-(void)moreSelectHeadView:(MoreSelectHeaderView *)headView didSelectedWithTag:(NSInteger)tag;

@end

@interface MoreSelectHeaderView : UITableViewHeaderFooterView
/**< 组标题 */
@property (nonatomic, strong) UILabel  *sectionTitleLabel;
/**< 指示图片 */
@property (nonatomic, strong) UIImageView  *indictorImageView;
/** 联系人个数*/
@property (nonatomic,strong) UILabel  *contactNumberLabel;
  /**< 代理 */
@property (nonatomic, weak) id <MoreSelectHeaderViewDelegate> delegate;



@end
