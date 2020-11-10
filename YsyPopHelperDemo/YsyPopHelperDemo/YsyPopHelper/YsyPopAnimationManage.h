//
//  YsyPopAnimationManage.h
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YsyPopMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface YsyPopAnimationManage : NSObject
///x轴偏移
@property (nonatomic, assign) CGFloat offsetX;
///y轴偏移
@property (nonatomic, assign) CGFloat offsetY;
///蒙板
@property (nonatomic, strong) UIView  *maskView;
/** 进场动画设置
 * @param duration  持续时间
 * @param type      动画类型
 * @param position  最终位置
 */
- (void)animateWithView:(UIView *)view duration:(NSTimeInterval)duration animationType:(YsyPopStyle)type position:(YsyPosition)position;

/** 退场动画设置
 * @param view 根视图
 */
- (void)dismissAnimationForRootView:(UIView *)view duration:(NSTimeInterval)duration
animationType:(YsyDismissStyle)type;



@end

NS_ASSUME_NONNULL_END
