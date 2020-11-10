//
//  BaiDuView.m
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "BaiDuView.h"
#import "Masonry.h"

@interface BaiDuView ()

@property (nonatomic,strong) UIImageView *imgView;

@end


@implementation BaiDuView

#pragma mark - ***** 初始化 *****

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    
    [self addSubview:self.imgView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
}

- (UIImageView *)imgView {
    if(_imgView) return _imgView;
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"baidu"];
    return _imgView;
}


@end
