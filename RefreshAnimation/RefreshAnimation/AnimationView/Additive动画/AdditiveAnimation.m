//
//  AdditiveAnimation.m
//  RefreshAnimation
//
//  Created by Weimob on 2019/5/28.
//  Copyright © 2019 com.shuxuan.fwex. All rights reserved.
//

#import "AdditiveAnimation.h"

@interface AdditiveAnimation()

@property (nonatomic, strong) CALayer  *preLayer;

@property (nonatomic, strong) UIButton *startAnimation;


@end


@implementation AdditiveAnimation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - setup

- (void)setup {
    
    self.preLayer                 = [CAShapeLayer layer];
    self.preLayer.frame           = CGRectMake(0, 0, 30, 30);
    self.preLayer.backgroundColor = [UIColor redColor].CGColor;
    self.preLayer.cornerRadius    = 15.f;
    self.preLayer.position        = self.center;
    
    UIBezierPath *beziPath = [UIBezierPath bezierPath];
    [beziPath addArcWithCenter:self.center radius:150. startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *shaplayer = [CAShapeLayer layer];
    shaplayer.path = beziPath.CGPath;
    shaplayer.lineWidth = 5.0;
    shaplayer.strokeColor = [UIColor whiteColor].CGColor;
    shaplayer.fillColor = [UIColor clearColor].CGColor;
    [shaplayer strokeEnd];
    [self.layer addSublayer:shaplayer];

    
    [self.layer addSublayer:self.preLayer];
    [self addSubview:self.startAnimation];
}


- (void)openCloseAnimation:(UIButton *)button {
    
    button.selected = !button.selected;
    
    if (button.selected) {
        [self startAnimation:nil];
    } else {
        [self stopAnimation:nil];
    }
}



- (void)startAnimation:(UIButton *)button {
    
    UIBezierPath *smallPath = [UIBezierPath bezierPath];
    [smallPath addArcWithCenter:CGPointMake(0, 0) radius:50.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    shakeAnimation.keyPath = @"position";
    shakeAnimation.path = smallPath.CGPath;
    shakeAnimation.values = @[@0, @10, @-10, @10, @0 ];
    shakeAnimation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    shakeAnimation.additive = YES;
    shakeAnimation.calculationMode = @"paced";
    shakeAnimation.duration = .8;

    shakeAnimation.repeatCount = HUGE_VALF;
    [self.preLayer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
    
    UIBezierPath *beipath = [UIBezierPath bezierPath];
    [beipath addArcWithCenter:CGPointMake(0, 0 ) radius:150.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath              = @"position";
    orbit.path                 = beipath.CGPath;
    orbit.additive             = YES;
    orbit.calculationMode = @"paced";
    orbit.repeatCount = HUGE_VALF;
    orbit.duration = 4;

    [self.preLayer addAnimation:orbit forKey:@"capAnimation"];
    
    
}

- (void)stopAnimation:(UIButton *)button {
    
    [self.preLayer removeAllAnimations];
    
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



@end
