//
//  TextAnimation.m
//  RefreshAnimation
//
//  Created by xsd on 2018/1/30.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "TextAnimation.h"
#import "UIBezierPath+GFPath.h"

@interface TextAnimation()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UIButton *animationButton;

@property (nonatomic, strong) NSString *textString;

@property (nonatomic, strong) NSString *animationString;

@property (nonatomic, strong) UIFont *textPreFont;

@property (nonatomic, strong) UIFont *textLerFont;

@property (nonatomic, strong) UIBezierPath *preBezierPath;

@property (nonatomic, strong) UIBezierPath *lerBezierPath;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation TextAnimation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.textString = @"I will be the best!";
        self.animationString = @"测试动画后，这样更帅？";
        
        self.textPreFont = [UIFont fontWithName:@"Zapfino" size:30.];//[UIFont systemFontOfSize:40.];
        self.textLerFont = [UIFont fontWithName:@"Arial" size:40.];//[UIFont systemFontOfSize:40.];
        
        [self addSubview:self.animationButton];
        [self addSubview:self.slider];
        
        self.gradientLayer.mask = self.shapeLayer;
        [self.layer addSublayer:self.gradientLayer];
        
        [self.shapeLayer setPath:self.preBezierPath.CGPath];
        [self.shapeLayer strokeEnd];
        [self.shapeLayer setStrokeEnd:0.0];
        
        NSLog(@"%@",[UIFont familyNames]);
    }
    return self;
}

#pragma mark - action
- (void)animationAction:(UIButton *)button {
    
    [self.shapeLayer removeAllAnimations];
    self.shapeLayer.strokeEnd = 1.0;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];//@"path"];
    animation.duration = 2;
    animation.fromValue = @(0.0);//(__bridge id)self.preBezierPath.CGPath;
    animation.toValue = @(1);//(__bridge id)self.lerBezierPath.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    
    [self.shapeLayer addAnimation:animation forKey:@"testAnimation"];
}

- (void)sliderAnimation:(UISlider *)silder {
    
    [self.shapeLayer removeAllAnimations];
    
    [self.shapeLayer setStrokeEnd:silder.value];
}

#pragma mark - lazy
- (UIButton *)animationButton {
    
    if (!_animationButton) {
        
        _animationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _animationButton.frame = CGRectMake(self.width - 30 - 50, 110, 50, 30.);
        [_animationButton setTitle:@"动画" forState:UIControlStateNormal];
        [_animationButton addTarget:self action:@selector(animationAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _animationButton;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(0, 0, self.width, self.height - 250);
        [_shapeLayer setStrokeColor:[UIColor redColor].CGColor];
        [_shapeLayer setFillColor:[UIColor clearColor].CGColor];
        _shapeLayer.masksToBounds = YES;
    }
    return _shapeLayer;
}

- (UIBezierPath *)preBezierPath {
    if (!_preBezierPath) {
        _preBezierPath = [UIBezierPath bezierPathWithText:self.textString font:self.textPreFont];
    }
    return _preBezierPath;
}

- (UIBezierPath *)lerBezierPath {
    if (!_lerBezierPath) {
        _lerBezierPath = [UIBezierPath bezierPathWithText:self.animationString font:self.textLerFont];
        
    }
    return _lerBezierPath;
}
- (UISlider *)slider {
    
    if (!_slider) {
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 80, self.width - 100, 20.)];
        [_slider addTarget:self action:@selector(sliderAnimation:) forControlEvents:UIControlEventValueChanged];
        _slider.maximumValue = 1.0;
        _slider.minimumValue = 0.0;
    }
    return _slider;
}

- (CAGradientLayer *)gradientLayer {
    
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 250, self.width, self.height - 250);
        [_gradientLayer setColors:@[ (__bridge id)[UIColor redColor].CGColor,
                                     (__bridge id)[UIColor yellowColor].CGColor,
                                     (__bridge id)[UIColor purpleColor].CGColor,
                                     (__bridge id)[UIColor greenColor].CGColor]];
       /*
        [_gradientLayer setLocations:@[@(0.0),
                                       @(0.25),
                                       @(0.5),
                                       @(0.75)]];
        */
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
      
        [_gradientLayer setEndPoint:CGPointMake(1, 0)];
    }
    return _gradientLayer;
}
@end
