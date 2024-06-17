// CustomDualSlider.m

#import "LMCustomDualSlider.h"

@implementation LMCustomDualSlider {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Customize appearance
    self.backgroundColor = [UIColor clearColor];
    self.thumbColor1 = [UIColor blueColor]; // Customize as needed
    self.thumbColor2 = [UIColor redColor]; // Customize as needed
    self.trackColor = [UIColor lightGrayColor]; // Customize as needed
    self.trackHighlightColor = [UIColor blueColor]; // Customize as needed
    
    // Add track
    track = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2 - 1, self.bounds.size.width, 10)];
    track.backgroundColor = self.trackColor;
    [self addSubview:track];
    
    // Add thumbs
    thumb1 = [self createThumb];
    thumb2 = [self createThumb];
    thumb1.backgroundColor = self.thumbColor1;
    thumb2.backgroundColor = self.thumbColor2;
    [track addSubview:thumb1];
    [track addSubview:thumb2];
    
    // Set initial values
    self.minValue = 0;
    self.maxValue = 100;
    self.currentValue1 = 10;
    self.currentValue2 = 30;
}

- (UIView *)createThumb {
    UIView *thumb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]; // Customize thumb size
    thumb.backgroundColor = UIColor.redColor;
    thumb.layer.cornerRadius = thumb.bounds.size.width / 2;
    thumb.layer.masksToBounds = YES;
    thumb.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [thumb addGestureRecognizer:panGesture];
    
    return thumb;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Layout thumbs
    CGFloat thumbWidth = thumb1.bounds.size.width;
    CGFloat trackWidth = self.bounds.size.width - thumbWidth;
    CGFloat thumb1X = trackWidth * (self.currentValue1 - self.minValue) / (self.maxValue - self.minValue);
    CGFloat thumb2X = trackWidth * (self.currentValue2 - self.minValue) / (self.maxValue - self.minValue);
    
    thumb1.frame = CGRectMake(thumb1X, self.bounds.size.height / 2 - thumb1.bounds.size.height / 2, thumb1.bounds.size.width, thumb1.bounds.size.height);
    thumb2.frame = CGRectMake(thumb2X, self.bounds.size.height / 2 - thumb2.bounds.size.height / 2, thumb2.bounds.size.width, thumb2.bounds.size.height);
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIView *thumb = gesture.view;
    CGPoint translation = [gesture translationInView:self];
    
    CGFloat minX = 0;
    CGFloat maxX = self.bounds.size.width - thumb.bounds.size.width;
    CGFloat newX = thumb.frame.origin.x + translation.x;
    newX = MAX(minX, MIN(newX, maxX));
    
    if (thumb == thumb1) {
        self.currentValue1 = newX / (self.bounds.size.width - thumb.bounds.size.width) * (self.maxValue - self.minValue) + self.minValue;
    } else if (thumb == thumb2) {
        self.currentValue2 = newX / (self.bounds.size.width - thumb.bounds.size.width) * (self.maxValue - self.minValue) + self.minValue;
    }
    
    [gesture setTranslation:CGPointZero inView:self];
    
    [self setNeedsLayout];
    
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        // Handle end of gesture if needed
    }
}

@end
