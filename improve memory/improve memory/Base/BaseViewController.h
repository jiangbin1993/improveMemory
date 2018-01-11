//
//  BaseViewController.h
//  improve memory
//
//  Created by 斌 on 2017/12/13.
//  Copyright © 2017年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,weak) UIButton *rightBtn;
@property (nonatomic,weak) UIButton *leftBtn;
@property (nonatomic,weak) UIView *navView;
@property (nonatomic,weak) UILabel *navTitleLabel;

- (void)createNav;

@end
