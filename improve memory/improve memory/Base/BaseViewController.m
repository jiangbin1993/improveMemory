//
//  BaseViewController.m
//  improve memory
//
//  Created by 斌 on 2017/12/13.
//  Copyright © 2017年 斌. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self createNav];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

// 创建“导航栏”
- (void)createNav{
    
        // 隐藏系统导航栏
        self.navigationController.navigationBar.hidden = YES;
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kNavigationHeight)];
        navView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:navView];
        self.navView = navView;
        navView.layer.shadowColor = [[UIColor grayColor] CGColor];
        navView.layer.shadowOffset = CGSizeMake(0, 2);
        navView.layer.shadowRadius = 5;
        navView.layer.shadowOpacity = .5;
        
        // 创建导航栏的titleLabel
        UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithHexString:UI_NAVIGATION_TEXT_COLOR];
    titleLabel.font = [UIFont systemFontOfSize:JJFont(35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.width = kScreenWidth / 2;
    titleLabel.height = 30;
        titleLabel.centerX = navView.width / 2;
        titleLabel.endY = navView.height - 10;
        [navView addSubview:titleLabel];
        self.navTitleLabel = titleLabel;
        
        // 创建导航栏右边按钮
        UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
    [right setTitleColor:[UIColor colorWithHexString:UI_NAVIGATION_TEXT_COLOR] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:right];
        self.rightBtn = right;
        
        // 创建导航栏左按钮
        UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
        [left addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:left];
    [left setTitleColor:[UIColor colorWithHexString:UI_NAVIGATION_TEXT_COLOR] forState:UIControlStateNormal];
        self.leftBtn = left;
}

- (void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction{
    
}


- (void)hideKeyboard{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
