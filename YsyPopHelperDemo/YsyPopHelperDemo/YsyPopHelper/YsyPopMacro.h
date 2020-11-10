//
//  YsyPopMacro.h
//  YsyPopMacro
//
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#ifndef SKMacro_h
#define SKMacro_h

#define MyWidth        [UIScreen mainScreen].bounds.size.width
#define MyHeight       [UIScreen mainScreen].bounds.size.height
#define WindowCenter   [UIApplication sharedApplication].keyWindow.center

#import "Masonry.h"
/** 显示动画样式 */
typedef NS_ENUM(NSInteger, YsyPopStyle) {
    YsyPopStyleFade,                   // 渐变效果
    YsyPopStyleScale,                  // 缩放 先放大 后恢复至原大小
    YsyPopStyleSmoothFromTop,          // 顶部 平滑淡入动画
    YsyPopStyleSmoothFromLeft,         // 左侧 平滑淡入动画
    YsyPopStyleSmoothFromBottom,       // 底部 平滑淡入动画
    YsyPopStyleSmoothFromRight,        // 右侧 平滑淡入动画
    YsyPopStyleSpringFromTop,          // 顶部 平滑淡入动画 带弹簧
    YsyPopStyleSpringFromLeft,         // 左侧 平滑淡入动画 带弹簧
    YsyPopStyleSpringFromBottom,       // 底部 平滑淡入动画 带弹簧
    YsyPopStyleSpringFromRight,        // 右侧 平滑淡入动画 带弹簧
};
/** 消失动画样式 */
typedef NS_ENUM(NSInteger, YsyDismissStyle) {
    YsyDismissStyleScale,                // 缩放
    YsyDismissStyleSmoothToTop,          // 顶部 平滑淡出动画
    YsyDismissStyleSmoothToLeft,         // 左侧 平滑淡出动画
    YsyDismissStyleSmoothToBottom,       // 底部 平滑淡出动画
    YsyDismissStyleSmoothToRight,        // 右侧 平滑淡出动画
};
/**弹框位置 */
typedef NS_ENUM(NSInteger, YsyPosition) {
    YsyPositonCenter = 0,
    YsyPositonTop,    //贴顶
    YsyPositonLeft,   //贴左
    YsyPositonBottom, //贴底
    YsyPositonRight,  //贴右
};
#endif /* YsyPopMacro */

