//
//  UIImage+Round.m
//  FZ
//
//  Created by mengdy on 17/3/2.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "UIImage+Round.h"

@implementation UIImage (Round)

//切割图片  设置圆角
+(UIImage *)hyb_imageWithCornerRadius:(CGFloat)radius imageName:(NSString *)name
{

    UIImage *image = [UIImage imageNamed:name];
    
    CGRect rect = (CGRect){0.f,0.f,image.size};

    UIGraphicsBeginImageContextWithOptions(image.size, NO,
                                           UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect
                                                cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawInRect:rect];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
