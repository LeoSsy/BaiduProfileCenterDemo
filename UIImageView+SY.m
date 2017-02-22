/**************************************************************************
 *
 *  Created by 舒少勇 on 2017/2/21.
 *    Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-汇道-搏击项目
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/
#import "UIImageView+SY.h"
#import <ImageIO/ImageIO.h>

@implementation UIImageView (SY)

+ (instancetype)gifWithName:(NSString*)name frame:(CGRect)frame
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    NSString *url = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSData *gifData = [NSData dataWithContentsOfFile:url];
    //图片源数据
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    //获取图片类型
    CFStringRef type =  CGImageSourceGetType(src);
    NSLog(@"%@",(__bridge NSString *)type);
    if (src&&[[(__bridge NSString *)type lowercaseString] containsString:@"gif"]) {
        //解析数据
        NSMutableArray *frames = nil;
        CGFloat animationDuration = 0.f;
        //获取图片的帧数
        size_t count = CGImageSourceGetCount(src);
        //初始化数组
        frames = [NSMutableArray arrayWithCapacity:count];
        //创建每一帧图片
        for (int i = 0 ; i<count ; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
            UIImage *uimage = [UIImage imageWithCGImage:image];
            [frames addObject:uimage];
        }
        CFRelease(src);
        imageV.image = [frames objectAtIndex:0];
        [imageV setAnimationImages:frames];
        [imageV setAnimationDuration:animationDuration];
        [imageV startAnimating];
        return imageV;
    }else{
        imageV.image = name?[UIImage imageNamed:name]:nil;
        return imageV;
    }
}

@end
