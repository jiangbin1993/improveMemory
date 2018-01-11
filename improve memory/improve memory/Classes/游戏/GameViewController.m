//
//  GameViewController.m
//  improve memory
//
//  Created by 斌 on 2018/1/9.
//  Copyright © 2018年 斌. All rights reserved.
//

#import "GameViewController.h"
#import "PPNumberButton.h"
#import "GameRulerViewController.h"

@interface GameViewController ()
// 第一个view
@property(nonatomic,strong) UIView *firstView;

@property(nonatomic,weak) UIScrollView *numberScrollView;

// 数字label
@property(nonatomic,strong) UILabel *numberLabel;

// 时间label
@property(nonatomic,strong) UILabel *timeLabel;

// 数字位数
@property(nonatomic,assign) NSInteger numberCount;

// 生成的随机数字字符串
@property(nonatomic,strong) NSString *numberString;

// 定时器
@property(nonatomic,strong) NSTimer *timer;

// 计数
@property(nonatomic,assign) NSInteger count;

// 倒计时时间
@property(nonatomic,assign) NSInteger time;


// 第二个view
@property(nonatomic,weak) UIView *secondView;

// 答案输入框
@property(nonatomic,weak) UITextField *answerTF;

// 时间label
@property(nonatomic,strong) UILabel *timeLabel2;

// 第三个view
@property(nonatomic,weak) UIView *thirdView;

// 输入的答案
@property(nonatomic,strong) NSString *inputAnswer;

// 正确答案
@property(nonatomic,strong) NSString *correctAnswer;

// 第四个view
@property(nonatomic,weak) UIView *forthView;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitleLabel.text = @"游戏";
    
    self.numberCount = 10;
    
    [self createUI];
}

// 布局
- (void)createUI{
    
    self.view.backgroundColor = [UIColor blackColor];
   
    [self createNavigation];
    
    //    第一个view
    [self createFirstView];
    
}

- (void)createNavigation{
    
    [self createNav];
    self.navTitleLabel.text = @"游戏";
    [self.rightBtn setTitle:@"游戏规则" forState:UIControlStateNormal];
    [self.rightBtn sizeToFit];
    self.rightBtn.centerY = self.navTitleLabel.centerY;
    self.rightBtn.endX = self.navView.width - 10;
}

// 创建第一个view
- (void)createFirstView{
    self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTabbarHeight)];
    [self.view addSubview:_firstView];
    
    
    PPNumberButton *numberButton = [[PPNumberButton alloc] initWithFrame:CGRectMake(100, 100, 90, 26)];
    numberButton.borderColor = [UIColor colorWithHexString:UI_TEXT_COLOR_BLACK];
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.maxValue = 999;
    numberButton.currentNumber = self.numberCount;
    numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus) {
        self.numberCount = number;
    };
    [self.firstView addSubview:numberButton];
    
    
    UIScrollView *numberScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, k6sHeight(300), kScreenWidth, k6sHeight(300))];
    [self.firstView addSubview:numberScrollView];
    self.numberScrollView = numberScrollView;
    
    //    数字Label
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.width = kScreenWidth - 20;
    self.numberLabel.height = self.numberScrollView.height;
    self.numberLabel.x = 10;
    _numberLabel.numberOfLines = 0;
    _numberLabel.font = [UIFont systemFontOfSize:JJFont(50)];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [numberScrollView addSubview:_numberLabel];
    
    
    
    //    时间Label
    self.timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:JJFont(30)];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.mas_equalTo(numberScrollView.mas_bottom).offset(20);
    }];
    
    
    UIButton *startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitleColor:[UIColor colorWithHexString:UI_TEXT_COLOR_BLACK] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [startBtn sizeToFit];
    [_firstView addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberButton.mas_right).offset(20);
        make.centerY.equalTo(numberButton.mas_centerY);
    }];
    
    
    UIButton *answerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [answerBtn setTitleColor:[UIColor colorWithHexString:UI_TEXT_COLOR_BLACK] forState:UIControlStateNormal];
    answerBtn.backgroundColor = [UIColor whiteColor];
    [answerBtn setTitle:@"提前答题" forState:UIControlStateNormal];
    [answerBtn addTarget:self action:@selector(answerAction) forControlEvents:UIControlEventTouchUpInside];
    [answerBtn sizeToFit];
    answerBtn.endY = _firstView.height - 30;
    answerBtn.centerX = kScreenWidth / 2;
    [_firstView addSubview:answerBtn];
}

// 创建第二个view
- (void)createSecondView{
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTabbarHeight)];
    secondView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:secondView];
    self.secondView = secondView;
    
    UITextField *answerTF = [[UITextField alloc] init];
    answerTF.backgroundColor = [UIColor whiteColor];
    answerTF.placeholder = @"请输入答案";
    answerTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.secondView addSubview:answerTF];
    [answerTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kScreenHeight * 0.2);
        make.centerX.equalTo(secondView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(kScreenWidth * 0.7);
    }];
    self.answerTF = answerTF;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(answerTF);
        make.height.mas_equalTo(30);
        make.top.equalTo(answerTF.mas_bottom).offset(30);
        make.width.mas_equalTo(80);
    }];
    
    //    时间Label
    self.timeLabel2 = [[UILabel alloc] init];
    _timeLabel2.font = [UIFont systemFontOfSize:JJFont(30)];
    _timeLabel2.textColor = [UIColor whiteColor];
    _timeLabel2.text = [NSString stringWithFormat:@"%ld秒后结束答题",self.time];
    _timeLabel2.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:_timeLabel2];
    [_timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(button.mas_bottom).offset(30);
    }];
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer2Action) userInfo:nil repeats:YES];
}

// 创建第三个view
- (void)createThirdView{
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTabbarHeight)];
    thirdView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:thirdView];
    self.thirdView = thirdView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 60)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [thirdView addSubview:label];
    if ([self.inputAnswer isEqualToString:self.numberString]) {
        label.text = @"恭喜您答对了！";
    }else{
        label.text = @"回答错误！";
        UILabel *label2 = [[UILabel alloc] init];
        label2.textColor = [UIColor whiteColor];
        label2.text = [NSString stringWithFormat:@"您的答案是：%@",_inputAnswer];
        [thirdView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom);
            make.left.right.equalTo(thirdView);
            make.height.mas_equalTo(60);
        }];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.textColor = [UIColor whiteColor];
        label3.numberOfLines = 0;
        label3.text = [NSString stringWithFormat:@"正确答案是：%@",_correctAnswer];
        [thirdView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom);
            make.left.right.equalTo(thirdView);
            make.height.mas_equalTo(60);
        }];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"再来一局" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(anotherGame) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdView);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.mas_equalTo(80);
    }];
}

// 创建第四个view
- (void)createForthView{
    UIView *forthView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - kTabbarHeight)];
    forthView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:forthView];
    self.forthView = forthView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 60)];
    label.text = @"时间到了！";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [forthView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = [UIColor whiteColor];
    label2.numberOfLines = 0;
    label2.text = [NSString stringWithFormat:@"正确答案是：%@",_correctAnswer];
    [forthView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.equalTo(forthView);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"再来一局" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(anotherGame) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forthView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(forthView);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.mas_equalTo(80);
    }];
    
}

- (void)rightBtnAction{
    GameRulerViewController *vc = [[GameRulerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

// 开始按钮方法
- (void)startAction{
    self.time = self.numberCount;
    self.count = 0;
    [self.timer invalidate];
    [self createNumber];
    _numberLabel.text = _numberString;
    [_numberLabel sizeToFit];
    if (_numberLabel.width < kScreenWidth - 20) {
        _numberLabel.width = kScreenWidth - 20;
    }
    self.numberScrollView.contentSize = CGSizeMake(0, _numberLabel.height);
    self.timeLabel.text = [NSString stringWithFormat:@"%ld秒后开始答题",self.time];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

// 计时器方法
- (void)timerAction{
    self.count ++;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld秒后开始答题",self.time-self.count];
    NSLog(@"%ld",self.count);
    if (self.count >= self.time) {
        [self.timer invalidate];
        [self createSecondView];
        [self getCorrectAnswer];
    }
}

- (void)timer2Action{
    self.count ++;
    self.timeLabel2.text = [NSString stringWithFormat:@"%ld秒后结束答题",_time-_count];
    NSLog(@"%ld",self.count);
    if (self.count >= self.time) {
        [self.timer invalidate];
        [self createForthView];
    }
}

// 提前答题按钮方法
- (void)answerAction{
    if (!_numberString) {
        return;
    }
    [self.timer invalidate];
    [self createSecondView];
    [self getCorrectAnswer];
}

// 确定按钮方法
- (void)sureAction{
    [self.timer invalidate];
    self.inputAnswer = self.answerTF.text;
    [self createThirdView];
}

// 计算正确答案
- (void)getCorrectAnswer{
    self.correctAnswer = self.numberString;
}

// 再来一局按钮方法
- (void)anotherGame{
    [self.thirdView removeFromSuperview];
    [self.secondView removeFromSuperview];
    [self.forthView removeFromSuperview];
    self.numberLabel.text = @"";
    self.timeLabel.text = @"";
    self.numberString = nil;
    
}

// 生成一个随机数字
- (void)createNumber{
    self.numberString = @"";
    for (int i = 0; i < _numberCount; i++) {
        int randomNum = arc4random() % 10;
        NSString *random = [NSString stringWithFormat:@"%d",randomNum];
        _numberString = [_numberString stringByAppendingString:random];
    }
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
