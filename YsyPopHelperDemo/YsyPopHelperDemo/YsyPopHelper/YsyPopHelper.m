//
//  YsyPopHelper.m
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "YsyPopHelper.h"
#import "YsyPopAnimationManage.h"

@interface YsyPopHelper ()
{
    UITapGestureRecognizer *_dismissGesture;
}
@property (nonatomic, strong) UIView                *popView;// 弹窗部分
@property (nonatomic, strong) UIImageView           *grayBackground;
@property (nonatomic, strong) YsyPopAnimationManage *animationManage;
@property (nonatomic, assign) YsyPopStyle           popStyle;
@property (nonatomic, assign) YsyDismissStyle       dismissStyle;
@property (nonatomic, assign) YsyPosition           position;
@property (nonatomic,assign ) BOOL                  isShowKeyboard;//是否弹出键盘
@property (nonatomic, assign) CGFloat               avoidKeyboardOffset;//规避键盘偏移量
@end

@implementation YsyPopHelper

- (instancetype)initWithCustomView:(UIView *_Nonnull)customView
    popStyle:(YsyPopStyle)popStyle
dismissStyle:(YsyDismissStyle)dismissStyle
    position:(YsyPosition)position{
    if ([super init]) {
        if (self) {
            self.frame = CGRectMake(0, 0, MyWidth, MyHeight);
            self.isAvoidKeyboard = YES;
            self.avoidKeyboardSpace = 10;
            self.popDuration = 0.5;
            self.dismissDuration = 0.5;
            self.offsetX = 0;
            self.offsetY = 0;
            self.popStyle = popStyle;
            self.dismissStyle = dismissStyle;
            self.position = position;
            [self initUI:customView];
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
        }
    }
    return self;
}
- (void)setSuperView:(UIView *)superView{
    _superView = superView;
    [superView addSubview:self];
}
#pragma mark - 创建界面
- (void)initUI:(UIView *)customView{
    // 灰色背景
    _grayBackground = [UIImageView new];
    [self addSubview:_grayBackground];
    _grayBackground.userInteractionEnabled = YES;
    [_grayBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [_grayBackground addGestureRecognizer:_dismissGesture];
    
    // 弹窗部分
    self.popView = customView;
    [self insertSubview:self.popView aboveSubview:_grayBackground];
}
- (void)setDisableTapBg:(BOOL)disableTapBg{
    _disableTapBg = disableTapBg;
    if (disableTapBg) {
        [_grayBackground removeGestureRecognizer:_dismissGesture];
    }
}
#pragma mark - 手势响应
- (void)cancel
{
    [self dismissAnimation];
}
#pragma mark - ***** 键盘弹出/收回 *****
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    _isShowKeyboard = YES;
    
    if (!self.isAvoidKeyboard) {
        return;
    }
    
    CGFloat customViewMaxY = CGRectGetMaxY(_popView.frame)+self.avoidKeyboardSpace;
    
    //取出键盘动画的时间(根据userInfo的key----UIKeyboardAnimationDurationUserInfoKey)
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //取得键盘最后的frame(根据userInfo的key----UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";)
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardMaxY = keyboardFrame.origin.y;
    
    //    CGFloat transformY = keyboardMaxY - self.frame.size.height;
    
    if (keyboardMaxY<customViewMaxY) {//键盘遮挡到弹框
        
        self.isAvoidKeyboard = YES;
        self.avoidKeyboardOffset = customViewMaxY - keyboardMaxY ;
        //执行动画
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.popView.frame;
            frame.origin.y = self.popView.frame.origin.y - self.avoidKeyboardOffset;
            self.popView.frame = frame;
        }];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification{
    
    _isShowKeyboard = NO;
    
    if (!self.isAvoidKeyboard) {
        return;
    }

    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.popView.frame;
        frame.origin.y = self.popView.frame.origin.y + self.avoidKeyboardOffset;
        self.popView.frame = frame;
    }];
}
- (void)dealloc
{
    NSLog(@"弹窗助手安全销毁");
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 外部调用
- (void)show
{
    [self displayAnimation];
}

- (void)dismiss
{
    [self dismissAnimation];
}

#pragma mark - 动画设置
- (void)displayAnimation
{
    self.animationManage = [[YsyPopAnimationManage alloc] init];
    self.animationManage.offsetX = self.offsetX;
    self.animationManage.offsetY = self.offsetY;
    self.animationManage.maskView = _grayBackground;
    [self.animationManage animateWithView:self.popView duration:self.popDuration animationType:self.popStyle position:self.position];
}

- (void)dismissAnimation
{
    [self.animationManage dismissAnimationForRootView:self duration:_dismissDuration animationType:self.dismissStyle];
}


@end
