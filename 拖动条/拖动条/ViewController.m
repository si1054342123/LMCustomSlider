//
//  ViewController.m
//  拖动条
//
//  Created by SLM on 2024/3/26.
//

#import "ViewController.h"
#import "LMCustomSlider.h"
#import "CustomDualSlider.h"
#import "UIView+ZFFrame.h"
@interface ViewController () <LMCustomSliderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LMCustomSlider *customSlider = [[LMCustomSlider alloc] initWithFrame:CGRectMake(20, 200, 350, 60)];
    [self.view addSubview:customSlider];
    customSlider.delegate = self;
    customSlider.rightCount = 70;
    customSlider.leftCount = 30;
}


- (void)sendLeftCount:(NSInteger)leftNumber
{
    NSLog(@"555555555555555555 : %ld",(long)leftNumber);
}

- (void)sendRightCount:(NSInteger)rightNumber
{
    NSLog(@"6666666666666666666666 : %ld",(long)rightNumber);
}

@end
