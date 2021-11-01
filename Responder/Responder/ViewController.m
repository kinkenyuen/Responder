//
//  ViewController.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "ViewController.h"
#import "BackgroundView.h"
#import "YellowView.h"
#import "BlueView.h"
#import "GreyView.h"
#import "PinkView.h"
#import "CyanView.h"
#import "MyButton.h"
#import "MyTableView.h"
#import "MyUITapGestureRecognizer.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)_hitTestForEventHandler {
    BackgroundView *background = [[BackgroundView alloc] init];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    
    YellowView *yellowView = [[YellowView alloc] init];
    yellowView.frame = CGRectMake(30, 64, 300, 250);
    [background addSubview:yellowView];
    
    BlueView *blueView = [[BlueView alloc] init];
    blueView.frame = CGRectMake(60, 250, 300, 250);
    [background addSubview:blueView];
    
    GreyView *grayView = [[GreyView alloc] init];
    grayView.frame = CGRectMake(50, 50, 100, 100);
    [yellowView addSubview:grayView];
    
    PinkView *pinkView = [[PinkView alloc] init];
    pinkView.frame = CGRectMake(50, 20, 200, 80);
    [blueView addSubview:pinkView];
    
    CyanView *cyanView = [[CyanView alloc] init];
    cyanView.frame = CGRectMake(50, 120, 200, 80);
    [blueView addSubview:cyanView];
}

// 手势、触摸事件、Target-Action混合场景例子
- (void)_gesture_touch_targetAction {
    BackgroundView *background = [[BackgroundView alloc] init];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [background addGestureRecognizer:tap];
    
    MyTableView *tv = [[MyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tv.dataSource = self;
    tv.delegate = self;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
    tv.tableFooterView = footer;
    [background addSubview:tv];
    
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(50, UIScreen.mainScreen.bounds.size.height - 60, 0, 0)];
    [button setTitle:@"按钮可点击" forState:UIControlStateNormal];
    [button sizeToFit];
    [button setBackgroundColor:UIColor.lightGrayColor];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:button];
}

// 离散型手势
// 如果父视图存在手势识别器，且在触摸事件传递过程中被手势识别器成功识别后
// 会由手势识别器处理，而取消触摸事件机制，也就是说Window首先将事件传给识别了的手势识别器处理
- (void)_test {
    YellowView *yellowView = [[YellowView alloc] init];
    yellowView.frame = CGRectMake(30, 100, 300, 200);
    [self.view addSubview:yellowView];
    
    MyUITapGestureRecognizer *tap = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [self.view addGestureRecognizer:tap];
}

// 持续型手势
// 如果父视图存在手势识别器，且在触摸事件传递过程中被手势识别器成功识别后
// 会由手势识别器处理，而取消触摸事件机制，也就是说Window首先将事件传给识别了的手势识别器处理
// 一开始拖动手势还没被完全识别，所以会有touches系列的触摸事件响应方法调用
- (void)_test1 {
    YellowView *yellowView = [[YellowView alloc] init];
    yellowView.frame = CGRectMake(30, 100, 300, 200);
    [self.view addSubview:yellowView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan)];
    
    // 表示触摸事件仍然会发送给hit-tested view
//    pan.cancelsTouchesInView = NO;
    
    // 表示触摸事件在被手势识别出结果之前，都不将触摸事件传递给hit-tested view
//    pan.delaysTouchesBegan = YES;
    
    /* 默认为YES。这种情况下发生一个touch时，在手势识别成功后,发送给touchesCancelled消息给hit-testview，手势识别失败时，会延迟大概0.15ms,期间没有接收到别的touch才会发送touchesEnded
        如果设置为NO，则不会延迟，即会立即发送touchesEnded以结束当前触摸
     */
//    pan.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:pan];
}

// 手势与target-action混合
// 一个按钮添加到一个view上，view绑定手势，按钮添加target-action
// 效果是优先触发target-action
/*
 kk | -[MyUITapGestureRecognizer touchesBegan:withEvent:]
 kk | touchesBegan : MyButton
 kk | beginTrackingWithTouch : MyButton
 kk | -[MyUITapGestureRecognizer touchesEnded:withEvent:]
 kk | touchesEnded : MyButton
 kk | endTrackingWithTouch : MyButton
 kk | Control触发
 */
- (void)_test2 {
    YellowView *yellowView = [[YellowView alloc] init];
    yellowView.frame = CGRectMake(30, 100, 300, 200);
    [self.view addSubview:yellowView];
    MyUITapGestureRecognizer *tap = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [yellowView addGestureRecognizer:tap];
    
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(20, 20, 0, 0)];
    [button setTitle:@"按钮点击" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [button setBackgroundColor:UIColor.whiteColor];
    [yellowView addSubview:button];
}

// 手势与target-action混合
// 一个按钮添加到一个view上，按钮绑定手势的同事，又添加target-action
// 效果是优先触发手势
/*
 kk | -[MyUITapGestureRecognizer touchesBegan:withEvent:]
 kk | touchesBegan : MyButton
 kk | beginTrackingWithTouch : MyButton
 kk | -[MyUITapGestureRecognizer touchesEnded:withEvent:]
 kk | 点击手势触发
 kk | touchesCancelled : MyButton
 kk | cancelTrackingWithEvent : MyButton
 */
- (void)_test3 {
    YellowView *yellowView = [[YellowView alloc] init];
    yellowView.frame = CGRectMake(30, 100, 300, 200);
    [self.view addSubview:yellowView];
    
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(20, 20, 0, 0)];
    [button setTitle:@"按钮点击" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [button setBackgroundColor:UIColor.whiteColor];
    [yellowView addSubview:button];
    MyUITapGestureRecognizer *tap = [[MyUITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [button addGestureRecognizer:tap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self _hitTestForEventHandler];
//    [self _gesture_touch_targetAction];
//    [self _test];
//    [self _test1];
//    [self _test2];
    [self _test3];
}

#pragma mark <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.textLabel setText:@"点击一下"];
        cell.backgroundColor = UIColor.orangeColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"kk | cell selected触发");
}

- (void)_tap {
    NSLog(@"kk | 点击手势触发");
}

- (void)_pan {
    NSLog(@"kk | 拖动手势触发");
}

- (void)_buttonAction {
    NSLog(@"kk | Control触发");
}

@end
