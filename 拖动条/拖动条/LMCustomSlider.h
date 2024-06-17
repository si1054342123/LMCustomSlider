//
//  LMCustomSlider.h
//  拖动条
//
//  Created by SLM on 2024/3/26.
//

#import <UIKit/UIKit.h>

@protocol LMCustomSliderDelegate <NSObject>
 
- (void)sendLeftCount:(NSInteger)leftNumber;

- (void)sendRightCount:(NSInteger)rightNumber;
 
@end


@interface LMCustomSlider : UIView


/// 左右两边的距离  (需要等距)  可以不用传  默认是 0
@property (nonatomic, assign) CGFloat leftRightDistance;

/// 左边的数值
@property (nonatomic, assign) NSInteger leftCount;

/// 右边的数值
@property (nonatomic, assign) NSInteger rightCount;


@property (nonatomic,weak) id<LMCustomSliderDelegate> delegate;


@end

