//
//  GameRulerViewController.m
//  improve memory
//
//  Created by 斌 on 2018/1/11.
//  Copyright © 2018年 斌. All rights reserved.
//

#import "GameRulerViewController.h"

@interface GameRulerViewController ()

@end

@implementation GameRulerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    [self.rightBtn removeFromSuperview];
    self.navTitleLabel.text = @"游戏规则";
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftBtn sizeToFit];
    self.leftBtn.x = 10;
    self.leftBtn.centerY = self.navTitleLabel.centerY;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight)];
    tv.editable = NO;
    tv.textColor = [UIColor colorWithHexString:UI_TEXT_COLOR_BLACK];
    tv.font = [UIFont systemFontOfSize:30];
    tv.text = @"机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个机个I文件个I价格IE我感觉额wig额外几个";
    [self.view addSubview:tv];
    
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
