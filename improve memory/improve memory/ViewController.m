//
//  ViewController.m
//  improve memory
//
//  Created by 斌 on 2017/11/17.
//  Copyright © 2017年 斌. All rights reserved.
//

#import "ViewController.h"
#import "UserViewController.h"
#import "PPNumberButton.h"

@interface ViewController ()

// 第一个view
@property(nonatomic,strong) UIView *firstView;

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


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberCount = 5;
    [self createUI];
    
}

// 布局
- (void)createUI{
    
    self.view.backgroundColor = [UIColor blackColor];
//    第一个view
    self.firstView = [[UIView alloc] init];
    [self.view addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    

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
    
    //    数字Label
    self.numberLabel = [[UILabel alloc] init];
    _numberLabel.numberOfLines = 0;
    _numberLabel.font = [UIFont systemFontOfSize:JJFont(30)];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(200);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.mas_equalTo(k6sHeight(300));
    }];
    
    
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
        make.top.mas_equalTo(_numberLabel.mas_bottom);
    }];
    
    
    UIButton *startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberButton.mas_right).offset(20);
        make.width.mas_equalTo(kScreenWidth * 0.2);
        make.height.mas_equalTo(kScreenHeight * 0.1);
        make.centerY.equalTo(numberButton.mas_centerY);
    }];
    
}

// 创建第二个view
- (void)createSecondView{
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
    _timeLabel2.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:_timeLabel2];
    [_timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.mas_equalTo(button.mas_bottom);
    }];
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer2Action) userInfo:nil repeats:YES];
}

// 创建第三个view
- (void)createThirdView{
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
        make.bottom.equalTo(self.view).offset(-20);
        make.width.mas_equalTo(80);
    }];
}

// 创建第四个view
- (void)createForthView{
    UIView *forthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
        make.bottom.equalTo(self.view).offset(-20);
        make.width.mas_equalTo(80);
    }];
    
}

// 开始按钮方法
- (void)startAction{
    self.time = 10;
    self.count = 0;
    [self.timer invalidate];
    [self createNumber];
    _numberLabel.text = _numberString;
    self.timeLabel.text = [NSString stringWithFormat:@"%lds",self.time];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

// 计时器方法
- (void)timerAction{
    self.count ++;
    self.timeLabel.text = [NSString stringWithFormat:@"%lds",self.time-self.count];
    NSLog(@"%ld",self.count);
    if (self.count >= self.time) {
        [self.timer invalidate];
        [self createSecondView];
         [self getCorrectAnswer];
    }
}

- (void)timer2Action{
    self.count ++;
    self.timeLabel2.text = [NSString stringWithFormat:@"%lds",_time-_count];
     NSLog(@"%ld",self.count);
    if (self.count >= self.time) {
        [self.timer invalidate];
        [self createForthView];
    }
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



// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}




@end
