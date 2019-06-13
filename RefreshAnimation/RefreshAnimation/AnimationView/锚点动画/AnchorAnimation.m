//
//  AnchorAnimation.m
//  RefreshAnimation
//
//  Created by Weimob on 2019/5/29.
//  Copyright © 2019 com.shuxuan.fwex. All rights reserved.
//

#import "AnchorAnimation.h"

@interface AnchorAnimation()

@property (nonatomic, strong) UIView *anchorView;
@property (nonatomic, strong) UIButton *startAnimation;

@end


@implementation AnchorAnimation


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.startAnimation];
        
        [self addSubview:self.anchorView];
        
        self.anchorView.layer.anchorPoint = CGPointMake(1, 1);
        self.anchorView.center = self.center;
        
    }
    return self;
}

- (void)openCloseAnimation:(UIButton *)button {
    
    CGAffineTransform transfomr = self.anchorView.transform;
    transfomr = CGAffineTransformRotate(transfomr, M_PI_4);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.anchorView.transform = transfomr;
    }];
}


#pragma mark - lazy
- (UIButton *)startAnimation {
    
    if (!_startAnimation) {
        
        _startAnimation = [UIButton buttonWithType:UIButtonTypeCustom];
        _startAnimation.frame = CGRectMake(15, 66, 100, 30);
        [_startAnimation addTarget:self action:@selector(openCloseAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [_startAnimation setTitle:@"打开动画" forState:UIControlStateNormal];
        [_startAnimation setTitle:@"关闭动画" forState:UIControlStateSelected];
    }
    return _startAnimation;
}

- (UIView *)anchorView {
    
    if (!_anchorView) {
        _anchorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 150.)];
        _anchorView.backgroundColor = [UIColor orangeColor];
        _anchorView.center = self.center;
    }
    return _anchorView;
}

@end
