//
//  TabBarViewController.m
//  improve memory
//
//  Created by 斌 on 2018/1/9.
//  Copyright © 2018年 斌. All rights reserved.
//

#import "TabBarViewController.h"
#import "UserViewController.h"
#import "RecordViewController.h"
#import "GameViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildControllerWithClassName:@"HomeViewController" title:@"" imageName:@"tab-radio" selectImageName:@"tab-radio-sel"];
    
}


// 设置子控制器
- (void)setChildControllerWithClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectName{
    
    Class class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = YES;
    nav.navigationBar.hidden = YES;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
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
