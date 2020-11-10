# YsyPopHelperDemo
在App项目开发过程中，总会对弹窗有各式各样的需求，有顶部的弹窗，顶部的弹窗，中间的弹窗等等各式各样，五花八门。弹窗的开发，一般包括有弹出动画，退出动画，半透明蒙板，弹窗本身的UI和逻辑等，如果每个弹窗都要走一遍这个流程，无意是一件低效且无聊的事情。那么有没有一种解决方案，可以让我们只需要编码弹窗本身的UI和逻辑呢？这就是笔者开源YsyPopHelper这个简单易用的iOS弹窗开发助手的目的。

简书地址：https://www.jianshu.com/p/81bf477f9a65


效果演示
https://www.jianshu.com/p/81bf477f9a65

##功能和用途
1.可自定义弹窗弹出，消失的动画和方向。
2.可自定义弹窗的位置。
3.自动规避键盘,防止被键盘遮挡。
4.支持指定弹框的父视图。
5.你只需要专注于弹窗本身的UI和业务逻辑即可。



```
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
```

##使用方法
```
    //初始化弹窗
    TestView *popView = [TestView new];
    popView.bounds  = CGRectMake(0, 0, 260,291 );
    //初始化弹窗助手
    _helper = [[YsyPopHelper alloc] initWithCustomView:popView popStyle:YsyPopStyleFade dismissStyle:YsyDismissStyleScale position:YsyPositonCenter];
    //弹窗助手调用展示方法
    [_helper show];
```
可以看到3行代码，即可使用弹窗，方便快捷，冗余度低。更多自定义需求，可参考Demo。要是你觉得好用，请点亮小星星🌟。
