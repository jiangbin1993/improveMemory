//
//  UIView+LayoutExtension.h
//  Mall
//
//  Created by SK.Pan on 2017/10/25.
//  Copyright © 2017年 GGZXC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

IB_DESIGNABLE

@interface UIView (LayoutExtension)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
//  结束x坐标(selfX + selfWidth)
@property (nonatomic, assign) CGFloat endX;
//  结束y坐标(selfY + selfHeight)
@property (nonatomic, assign) CGFloat endY;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

@end
