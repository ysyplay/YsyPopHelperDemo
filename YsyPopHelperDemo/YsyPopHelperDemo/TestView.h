//
//  TestView.h
//  YsyPopHelperDemo
//
//  Created by LH on 8/31/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TestViewDelegate <NSObject>
- (void)iKnowButtClick;
@end

@interface TestView : UIView
@property (nonatomic, weak) id<TestViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
