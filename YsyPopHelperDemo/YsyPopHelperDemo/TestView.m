//
//  TestView.m
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "TestView.h"
#import "Masonry.h"


@implementation TestView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10"]];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    [butt addTarget:self action:@selector(buttClick) forControlEvents:UIControlEventTouchUpInside];
    [butt setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [self addSubview:butt];
    [butt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-15);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(105);
    }];

}
- (void)buttClick{
    if ([self.delegate respondsToSelector:@selector(iKnowButtClick)]) {
        [self.delegate iKnowButtClick];
    }
}
-(void)dealloc{
    NSLog(@"弹窗安全销毁");
}
@end
