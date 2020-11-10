//
//  ViewController.m
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "ViewController.h"
#import "YsyPopHelper.h"
#import "TestView.h"
#import "BaiDuView.h"
@interface ViewController ()<TestViewDelegate>
@property (nonatomic,strong) YsyPopHelper *helper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"弹窗助手";
}
- (IBAction)topClick:(id)sender {
    BaiDuView *popView = [[BaiDuView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,MyWidth/1.95)];
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleSpringFromTop dismissStyle:YsyDismissStyleSmoothToTop position:YsyPositonTop];
    _helper.superView = self.view;
    _helper.offsetY = [[UIApplication sharedApplication] statusBarFrame].size.height+44;
    [_helper show];
}
- (IBAction)bottomClik:(id)sender {
    BaiDuView *popView = [[BaiDuView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,MyWidth/1.95)];
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleSpringFromBottom dismissStyle:YsyDismissStyleSmoothToBottom position:YsyPositonBottom];
    [_helper show];
}
- (IBAction)centerClik:(id)sender {
    TestView *popView = [TestView new];
    popView.bounds  = CGRectMake(0, 0, 260,291 );
    popView.delegate = self;
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleFade dismissStyle:YsyDismissStyleScale position:YsyPositonCenter];
    [_helper show];
}
- (IBAction)leftClik:(id)sender {
    TestView *popView = [TestView new];
    popView.bounds  = CGRectMake(0, 0, 260,291 );
    popView.delegate = self;
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleSmoothFromLeft dismissStyle:YsyDismissStyleSmoothToRight position:YsyPositonLeft];
    [_helper show];
}
- (IBAction)rightClick:(id)sender {
    TestView *popView = [TestView new];
    popView.bounds  = CGRectMake(0, 0, 260,291 );
    popView.delegate = self;
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleSpringFromRight dismissStyle:YsyDismissStyleSmoothToLeft position:YsyPositonRight];
    [_helper show];
}

//自定义弹窗代理
- (void)iKnowButtClick{
    NSLog(@"弹窗代理");
    [_helper dismiss];
    
}

@end
