//
//  CBCLabel.m
//  CBCSZ
//
//  Created by ych on 13-11-15.
//  Copyright (c) 2013年 ych. All rights reserved.
//
#define kTextFont [UIFont boldSystemFontOfSize:13]
#define kTextColor [UIColor colorWithRed:(32 / 255.0) green:(32 / 255.0) blue:(32 / 255.0) alpha:1]

#define PaomaLabelTimerInterval 0.1

#import "PaomaLabel.h"
static NSInteger times1;
static NSInteger anotherTimers;
@interface PaomaLabel ()
{
    NSTimer *_timer;
}
@end

@implementation PaomaLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    times1 = -1;
    anotherTimers = 0;
    if (nil != _timer) {
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:PaomaLabelTimerInterval
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)timerAction
{
    times1++;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGSize size = [_text sizeWithFont:_font == nil? kTextFont:_font];
    if (size.width > self.frame.size.width) {
        
        CGFloat perDistance = (size.width / _text.length) / 4;//每次移动4分之一个字的宽度
        CGFloat moveDistance = -(times1 * perDistance);
        if (abs(moveDistance) >= size.width) {
            //这个距离已经将文字移出屏幕可显示区域
            //让文字从最后边开始出现
            moveDistance = self.frame.size.width - anotherTimers * perDistance;
            times1 = - (anotherTimers + 1);
            anotherTimers = 0;
        }
        
        CGRect dRect = (CGRect){moveDistance,0,size.width,self.frame.size.height};
        
        [nil == _textColor? kTextColor:_textColor set];
        [_text drawInRect:dRect withFont:_font == nil? kTextFont:_font];
        
//        NSLog(@"move distance ===%f",moveDistance);
        
        CGFloat aDistance = (self.frame.size.width/2);//首尾文字的间隔
        if (moveDistance < 0 && (moveDistance + size.width) < aDistance) {
            
            //当文字即将移出屏幕时，在右侧开始绘制起始的几个文
            anotherTimers++;
            CGFloat appearTextLength = size.width + moveDistance;//还在显示的文字的长度
            CGFloat remainDistance = self.frame.size.width - appearTextLength - aDistance;//剩下的可以用于绘制文字的长度
            
            NSInteger subStringIndex = remainDistance/perDistance;
            NSString *subText = [_text substringToIndex:MIN(subStringIndex, _text.length - 1)];
            
            [subText drawInRect:(CGRect){self.frame.size.width - remainDistance,0,self.frame.size.width,self.frame.size.height}
                       withFont:_font == nil? kTextFont:_font];
//            NSLog(@"text====%@,timer====%i",subText,anotherTimers);
        }
        
        if (nil == _timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:PaomaLabelTimerInterval
                                                      target:self
                                                    selector:@selector(timerAction)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    }else
    {
        [nil == _textColor? kTextColor:_textColor set];
        [_text drawInRect:self.bounds withFont:_font == nil? kTextFont:_font];
    }
}

- (void)removeFromSuperview
{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc
{
    self.text = nil;
    self.textColor = nil;
    self.font = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
