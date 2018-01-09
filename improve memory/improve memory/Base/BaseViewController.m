//
//  BaseViewController.m
//  improve memory
//
//  Created by 斌 on 2017/12/13.
//  Copyright © 2017年 斌. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    NSString *_navTitle;
}

@property (nonatomic,weak) UIView *navView;

@property (nonatomic,weak) UILabel *navTitleLabel;

@end

@implementation BaseViewController

- (NSString *)navTitle{
    if (!self.navTitleLabel) {
        return _navTitle;
    }
    return self.navTitleLabel.text;
}

- (void)setNavTitle:(NSString *)navTitle{
    if (!self.navTitleLabel) {
        _navTitle = navTitle;
        return;
    }
    self.navTitleLabel.text = navTitle;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

// 创建“导航栏”
- (void)createNav{
    // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐藏系统导航栏
        self.navigationController.navigationBar.hidden = YES;
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kNavigationHeight)];
        navView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:navView];
        self.navView = navView;
        
        // 创建导航栏的titleLabel
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.navTitle;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - titleLabel.frame.size.width / 2, 0, titleLabel.frame.size.width, kNavigationBarHeight);
        [navView addSubview:titleLabel];
        self.navTitleLabel = titleLabel;
        
        // 创建导航栏右边按钮
        UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
        [right setTitle:@"下一页" forState:UIControlStateNormal];
        right.frame = CGRectMake(300, 0, 100, 44);
        [right addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:right];
        
        // 创建导航栏左按钮
        UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
        [left setTitle:@"上一页" forState:UIControlStateNormal];
        [left addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:left];
        left.frame = CGRectMake(0, 0, 100, 44);
    });
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
