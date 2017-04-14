//
//  SXBase.m
//  FZ
//
//  Created by mengdy on 16/10/17.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "SXBase.h"

//产生一个 from---to 之间的随机数
#define RandomNumber(from,to) ((int)((from) + (arc4random() % ((to) - (from) + 1))))

@implementation SXBase



NSString * getEncryptKey()
{
    static NSString *allchar = @"xlzxhxjnyj5u0evam0cmc8zkpxvg28ok";
    NSMutableString *enkey = [NSMutableString stringWithCapacity:32];
    NSUInteger len = allchar.length;
    while (len > 0) {
        int rand = RandomNumber(0,31);
        NSRange range = NSMakeRange(rand, 1);
        [enkey appendString:[allchar substringWithRange:range]];
        len--;
    }
    return enkey;
}








@end
