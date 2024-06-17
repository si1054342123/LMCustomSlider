//
//  LMCustomSlider.m
//  拖动条
//
//  Created by SLM on 2024/3/26.
//
#import "LMCustomSlider.h"
#import "UIView+ZFFrame.h"
#import "LMCustomInheritanceSlider.h"
@interface LMCustomSlider ()

@property (nonatomic, strong) LMCustomInheritanceSlider *lmTowSlider;


/// 左边的滑块
@property (nonatomic, strong) UIImageView *minImage;

/// 左边显示的 label
@property (nonatomic, strong) UILabel *minLabel;

/// 右边显示的 label
@property (nonatomic, strong) UILabel *maxLabel;

@end

@implementation LMCustomSlider


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _leftRightDistance = 0;
        _lmTowSlider = [[LMCustomInheritanceSlider alloc] init];
        _lmTowSlider.frame = CGRectMake(0, 0, frame.size.width, 60);
        _lmTowSlider.value = _rightCount;
        [_lmTowSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_lmTowSlider];
        
        
        UIView *minView = [[UIView alloc] init];
        minView.frame = CGRectMake(0, 0, frame.size.width * 15 / 100, 10);
        minView.backgroundColor = UIColor.redColor;
        [self addSubview:minView];
        minView.zf_centerY = _lmTowSlider.zf_centerY;
        [minView.layer setMasksToBounds:YES];
        [minView.layer setCornerRadius:5];
        [minView.layer setMaskedCorners:kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner];
        
        _minImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 23)];
        _minImage.layer.masksToBounds = YES;
        _minImage.zf_centerY = _lmTowSlider.zf_centerY;
        _minImage.userInteractionEnabled = true;
        _minImage.image = [UIImage imageNamed:@"img_bright"];
        [self addSubview:_minImage];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:) ];
        [_minImage addGestureRecognizer:pan];
        
        _minLabel = [[UILabel alloc] init];
        _minLabel.text = [NSString stringWithFormat:@"%ld%s",(long)_leftCount,"%"];
        _minLabel.frame = CGRectMake(0, 0, 40, 15);
        _minLabel.font = [UIFont systemFontOfSize:13];
        _minLabel.zf_centerX = _minImage.zf_centerX;
        [self addSubview:_minLabel];
        
        
        _maxLabel = [[UILabel alloc] init];
        _maxLabel.text = [NSString stringWithFormat:@"%ld%s",(long)_leftCount,"%"];
        _maxLabel.frame = CGRectMake(0, 0, 40, 15);
        _maxLabel.font = [UIFont systemFontOfSize:13];
        _maxLabel.zf_centerX = _minImage.zf_centerX;
        [self addSubview:_maxLabel];
        
        UILabel *min = [[UILabel alloc] init];
        min.frame = CGRectMake(0, frame.size.height - 15, 10, 15);
        min.text = @"0";
        min.font = [UIFont systemFontOfSize:12];
        [self addSubview:min];
        
        UILabel *max = [[UILabel alloc] init];
        max.frame = CGRectMake(frame.size.width-30, frame.size.height - 15, 30, 15);
        max.text = @"100";
        max.textAlignment = NSTextAlignmentRight;
        max.font = [UIFont systemFontOfSize:12];
        [self addSubview:max];
        

    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:_lmTowSlider];
    _leftCount = (gesture.view.center.x + translation.x)*100 / self.frame.size.width;
    [self changeMinLabelX:_leftCount];
    if (_leftCount >= _rightCount-1) {
        gesture.view.center = CGPointMake(self.frame.size.width*(_rightCount-1)/100, _lmTowSlider.zf_centerY);
        [gesture setTranslation:CGPointZero inView:_lmTowSlider];
        return;
    }
    if (gesture.view.center.x + translation.x <= self.leftRightDistance) {
        _minImage.center = CGPointMake(self.leftRightDistance, _lmTowSlider.zf_centerY);
        [gesture setTranslation:CGPointZero inView:_lmTowSlider];
        return;
    }
    if (gesture.view.center.x + translation.x >= self.frame.size.width) {
        gesture.view.center = CGPointMake(_lmTowSlider.zf_width+self.leftRightDistance-1, _lmTowSlider.zf_centerY);
        [gesture setTranslation:CGPointZero inView:_lmTowSlider];
        return;
    }
    
    if (gesture.view.center.x + translation.x <= self.frame.size.width * 15 / 100) {
        gesture.view.center = CGPointMake(self.frame.size.width * 15 / 100, _lmTowSlider.zf_centerY);
        [gesture setTranslation:CGPointZero inView:_lmTowSlider];
        return;
    }
    
    
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, _lmTowSlider.zf_centerY);
    [gesture setTranslation:CGPointZero inView:_lmTowSlider];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendLeftCount:)]){
        [self.delegate sendLeftCount:_leftCount];
    }
}


- (void)sliderValueChanged:(UISlider *)sender {
    [self changeMaxLabelX:_rightCount];
    
    if (sender.value <= _leftCount) {
        [self changeMaxLabelX:_rightCount+1];
        [sender setValue:_leftCount+2 animated:NO];
        return;
    }
    _rightCount = sender.value;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendRightCount:)]){
        [self.delegate sendRightCount:sender.value];
    }
}

- (void)changeMinLabelX:(NSInteger)count{
    _minLabel.zf_centerX = _minImage.zf_centerX+10;
    _minLabel.text = [NSString stringWithFormat:@"%ld%s",(long)count,"%"];
}

- (void)changeMaxLabelX:(NSInteger)count{
    _maxLabel.zf_centerX = self.frame.size.width * _rightCount / 100 +10;
    _maxLabel.text = [NSString stringWithFormat:@"%ld%s",(long)count,"%"];
}

#pragma mark - set
- (void)setRightCount:(NSInteger)rightCount
{
    _rightCount = rightCount;
    _lmTowSlider.value = rightCount;
    [self changeMaxLabelX:_rightCount];
}

- (void)setLeftCount:(NSInteger)leftCount
{
    _leftCount = leftCount;
    _minImage.zf_x = self.frame.size.width * leftCount / 100;
    [self changeMinLabelX:_leftCount];
}


@end
