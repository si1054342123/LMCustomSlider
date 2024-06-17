//
//  LMCustomInheritanceSlider.m
//  拖动条
//  
//  Created by SLM on 2024/3/26.
//

#import "LMCustomInheritanceSlider.h"

@implementation LMCustomInheritanceSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.minimumValue = 0;
        self.maximumValue = 100;
        [self setThumbImage:[UIImage imageNamed:@"img_bright"] forState:UIControlStateNormal];
        self.minimumTrackTintColor = UIColor.greenColor; // 左边的颜色
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 25, self.frame.size.width, 10);
}
@end
