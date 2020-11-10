//
//  YsyPopHelper.h
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YsyPopMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface YsyPopHelper : UIView
/**
 * 初始化方法
 *  @param customView   自定义弹窗
 *  @param popStyle     显示样式
 *  @param dismissStyle 消失样式
 *  @param position     弹窗位置
 */
- (instancetype)initWithCustomView:(UIView *_Nonnull)customView
    popStyle:(YsyPopStyle)popStyle
dismissStyle:(YsyDismissStyle)dismissStyle
    position:(YsyPosition)position;
/// 显示弹窗
- (void)show;
///消失弹窗
- (void)dismiss;
///弹出动画时间
@property (nonatomic, assign) NSTimeInterval popDuration;
///消失动画时间
@property (nonatomic, assign) NSTimeInterval dismissDuration;
///x轴偏移
@property (nonatomic, assign) CGFloat        offsetX;
///y轴偏移
@property (nonatomic, assign) CGFloat        offsetY;
///设置父视图，默认为window
@property (nonatomic, weak  ) UIView         *superView;
///是否规避键盘 默认YES
@property (nonatomic, assign) BOOL           isAvoidKeyboard;
///弹框和键盘的距离 默认10
@property (nonatomic, assign) CGFloat        avoidKeyboardSpace;
///半透明背景不可点击,默认点击背景弹窗消失
@property (nonatomic, assign) BOOL           disableTapBg;
@end

NS_ASSUME_NONNULL_END
