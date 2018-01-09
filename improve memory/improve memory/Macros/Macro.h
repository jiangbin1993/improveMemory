//
//  Macro.h
//  improve memory
//
//  Created by 斌 on 2017/12/7.
//  Copyright © 2017年 斌. All rights reserved.
//

#ifndef Macro_h
#define Macro_h




// 屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define k6sWidth(w)                     ((w) / 750.0 * kScreenWidth)
#define k6sHeight(h)                    ((h) / 1334.0 * kScreenHeight)

// 工具栏高度 iphoneX和其他型号不同
#define kToolBarHeight                  [[UIApplication sharedApplication] statusBarFrame].size.height

#define kNavigationBarHeight            44

#define kNavigationHeight               (kToolBarHeight + kNavigationBarHeight)

// 字体
#define JJFont(size) (kScreenWidth / 750.0 * size)


/*** 颜色 ***/
#define JJColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define JJColorRGB(r, g, b) JJColorA((r), (g), (b), 255)

#endif /* Macro_h */
