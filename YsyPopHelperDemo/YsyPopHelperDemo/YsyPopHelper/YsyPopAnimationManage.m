//
//  YsyPopAnimationManage.m
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "YsyPopAnimationManage.h"

@interface YsyPopAnimationManage () <CAAnimationDelegate>
@property (nonatomic, strong) UIView * animationView;// 执行动画的view
@property (nonatomic, assign) YsyPopStyle     popStyle;
@property (nonatomic, assign) YsyPosition     position;
@end

@implementation YsyPopAnimationManage

- (void)animateWithView:(UIView *)view duration:(NSTimeInterval)duration animationType:(YsyPopStyle)type position:(YsyPosition)position{
    _animationView = view;
    self.popStyle = type;
    self.position = position;
    
    //设置背景过渡动画
    self.maskView.backgroundColor = [self getNewColorWith:[UIColor blackColor] alpha:0.0];
    [UIView animateWithDuration:duration*0.7 animations:^{
        self.maskView.backgroundColor = [self getNewColorWith:[UIColor blackColor] alpha:0.5];
    }];
    
    
    [self setStartPosition];
    if (self.popStyle == YsyPopStyleScale) {
        [self animationWithLayer:view.layer duration:((0.3*duration)/0.7) values:@[@0.0, @1.2, @1.0]];
    }else if (self.popStyle == YsyPopStyleFade){
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[[self fadeAnimationGroup:duration]];
        animationGroup.duration = duration;
        [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
    }
    else{
        CGFloat damping = 1.0;
        if (type == YsyPopStyleSpringFromTop||
            type == YsyPopStyleSpringFromLeft||
            type == YsyPopStyleSpringFromBottom||
            type == YsyPopStyleSpringFromRight) {
            damping = 0.66;
        }
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.animationView.center = [self setStopPosition];
        } completion:nil];
    }
}
- (void)setStartPosition {
    CGFloat h = _animationView.bounds.size.height+20;
    CGFloat w = _animationView.bounds.size.width+20;
    switch (self.popStyle) {
        case YsyPopStyleSmoothFromTop:
        case YsyPopStyleSpringFromTop:
        {
            _animationView.center = CGPointMake(WindowCenter.x,  - h/2);
        }
            break;
        case YsyPopStyleSmoothFromLeft:
        case YsyPopStyleSpringFromLeft:
        {
            _animationView.center = CGPointMake(- w/2, WindowCenter.y);
        }
            break;
        case YsyPopStyleSmoothFromBottom:
        case YsyPopStyleSpringFromBottom:
        {
             _animationView.center = CGPointMake(WindowCenter.x, MyHeight + h/2);
        }
            break;
        case YsyPopStyleSmoothFromRight:
        case YsyPopStyleSpringFromRight:
        {
            _animationView.center = CGPointMake(MyWidth + w/2, WindowCenter.y);
        }
            break;
        default://居中
        {
            _animationView.center = WindowCenter;
        }
            break;
    }
}
- (CGPoint)setStopPosition{
    CGPoint point;
    switch (_position) {
        case YsyPositonTop:
        {
            point = CGPointMake(WindowCenter.x+_offsetX, _animationView.bounds.size.height/2+_offsetY);
        }
            break;
        case YsyPositonLeft:
        {
            point = CGPointMake(_animationView.bounds.size.width/2+_offsetX, WindowCenter.y+_offsetY);
        }
            break;
        case YsyPositonBottom:
        {
            point = CGPointMake(WindowCenter.x+_offsetX, MyHeight-_animationView.bounds.size.height/2+_offsetY/*-bottomMargin()*/);
        }
            break;
        case YsyPositonRight:
        {
             point = CGPointMake(MyWidth - _animationView.bounds.size.width/2+_offsetX, WindowCenter.y+_offsetY);
        }
            break;
        default:
        {
            point = WindowCenter;
        }
            break;
    }
    return point;
}
- (CABasicAnimation *)fadeAnimationGroup:(NSTimeInterval)duration
{
    CABasicAnimation * fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeAnimation.duration = duration;
    
    return fadeAnimation;
}
- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values {
    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    KFAnimation.duration = duration;
    KFAnimation.removedOnCompletion = NO;
    KFAnimation.fillMode = kCAFillModeForwards;
    KFAnimation.delegate = self;
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:values.count];
    for (NSUInteger i = 0; i<values.count; i++) {
        CGFloat scaleValue = [values[i] floatValue];
        [valueArr addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleValue, scaleValue, scaleValue)]];
    }
    KFAnimation.values = valueArr;
    KFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:KFAnimation forKey:nil];
}

#pragma mark ------------------------ 退场动画 ---------------------------------
- (void)dismissAnimationForRootView:(UIView *)view duration:(NSTimeInterval)duration
animationType:(YsyDismissStyle)type
{
    [UIView animateWithDuration:duration*0.8 animations:^{
        self.maskView.backgroundColor = [self getNewColorWith:[UIColor blackColor] alpha:0.0];
    }];
    
    if (type == YsyDismissStyleScale) {
        [self animationWithLayer:self.animationView.layer duration:(duration) values:@[@1.0, @0.66, @0.33, @0.01]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration+0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.animationView removeFromSuperview];
             self.animationView = nil;
            [view removeFromSuperview];
        });
    }else{
        CGPoint startPosition = self.animationView.layer.position;
        CGPoint endPosition = self.animationView.layer.position;
        if (type == YsyDismissStyleSmoothToTop) {
            endPosition = CGPointMake(startPosition.x, -(_animationView.bounds.size.height*0.5));
        } else if (type == YsyDismissStyleSmoothToBottom) {
            endPosition = CGPointMake(startPosition.x, MyHeight + _animationView.bounds.size.height*0.5);
        } else if (type == YsyDismissStyleSmoothToLeft) {
            endPosition = CGPointMake(-_animationView.bounds.size.width*0.5, startPosition.y);
        } else {
            endPosition = CGPointMake(MyHeight + _animationView.bounds.size.width*0.5, startPosition.y);
        }
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.animationView.layer.position = endPosition;
        } completion:^(BOOL finished) {
            [self.animationView removeFromSuperview];
             self.animationView = nil;
            [view removeFromSuperview];
        }];
    }
}
// 改变UIColor的Alpha
- (UIColor *)getNewColorWith:(UIColor *)color alpha:(CGFloat)alpha {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat resAlpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&resAlpha];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}
CGFloat statusHeight(){
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
CGFloat bottomMargin() {
    if (statusHeight()>20) {
        return 34;
    }
    return 0;
}

@end
