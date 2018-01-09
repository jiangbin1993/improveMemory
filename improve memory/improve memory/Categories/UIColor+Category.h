//
//  UIColor+Category.h
//  xiusekecai
//
//  Created by 斌 on 2016/11/17.
//  Copyright © 2016年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

// 十六进制转化为颜色
+ (UIColor *) colorWithHexString: (NSString *)color;

// r g b a 颜色转化
+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha;

@end
