//
//  ViewController.m
//  Responder
//
//  Created by jianqin_ruan on 2021/10/27.
//

#import "ViewController.h"
#import "KKView.h"
#import "KKViewA.h"
#import "KKViewB.h"
#import "KKButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KKView *view = [[KKView alloc] init];
    view.backgroundColor = UIColor.grayColor;
    view.frame = self.view.bounds;
    view.restorationIdentifier = @"background view";
    [self.view addSubview:view];
    
    KKViewA *v1 = [[KKViewA alloc] init];
    v1.frame = CGRectMake(15, 100, 200, 200);
    v1.backgroundColor = UIColor.redColor;
    v1.restorationIdentifier = @"red view";
    [view addSubview:v1];
    
//    KKButton *button = [KKButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"一个按钮" forState:UIControlStateNormal];
//    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    [button setBackgroundColor:UIColor.blackColor];
//    button.frame = CGRectMake(50, 100, 1, 1);
//    [button sizeToFit];
//    button.restorationIdentifier = @"kk_button";
//    [v1 addSubview:button];
//    [button addTarget:self action:@selector(_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
//    KKViewB *v2 = [[KKViewB alloc] init];
//    v2.frame = CGRectMake(30, 50, 100, 100);
//    v2.backgroundColor = UIColor.blueColor;
//    v2.restorationIdentifier = @"blue view";
//    v2.alpha = 0.5;
//    [v1 addSubview:v2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap)];
    [view addGestureRecognizer:tap];
}

- (void)_tap {
    NSLog(@"kk | %s", __func__);
}
- (void)_buttonAction {
    NSLog(@"kk | %s", __func__);
}

@end
