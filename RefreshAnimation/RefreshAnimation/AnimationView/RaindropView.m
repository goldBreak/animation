//
//  RaindropView.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "RaindropView.h"
#import "RaindropViewLayer.h"

@interface RaindropView()

@property (nonatomic, assign) BOOL animationStatue;
@property (nonatomic, strong) RaindropViewLayer *rainLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end


@implementation RaindropView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _animationStatue = NO;
        
        [self.gradientLayer setMask:self.rainLayer];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

- (void)setAnimationStatue:(BOOL)animationStatue {
    _animationStatue = animationStatue;
    //...
    if (animationStatue) {
        
        CABasicAnimation *basiAnimation = [CABasicAnimation animationWithKeyPath:@"animationOffset"];
        basiAnimation.duration = 1.0;
        basiAnimation.fromValue = @(0);
        basiAnimation.toValue = @(1);
        basiAnimation.autoreverses = YES;
        basiAnimation.fillMode = kCAFillModeForwards;
        basiAnimation.repeatCount = CGFLOAT_MAX;
        [self.rainLayer addAnimation:basiAnimation forKey:@"testAnimation"];
        
    } else {
        [self.rainLayer removeAllAnimations];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //animation start？？？
    self.animationStatue = !self.animationStatue;
}

#pragma mark - Lazy
- (RaindropViewLayer *)rainLayer {
    
    if (!_rainLayer) {
        _rainLayer = [[RaindropViewLayer alloc] init];
        _rainLayer.frame = self.frame;
        [_rainLayer setNeedsDisplay];
    }
    return _rainLayer;
}

- (CAGradientLayer *)gradientLayer {
    
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.frame;
        
        _gradientLayer.colors = @[
                                  (id)[UIColor redColor].CGColor,
                                  (id)[UIColor yellowColor].CGColor,
//                                  (id)[UIColor purpleColor].CGColor,
//                                  (id)[UIColor brownColor].CGColor,
                                  (id)[UIColor greenColor].CGColor];
        
        _gradientLayer.locations = @[
                                     @(0.0),
//                                     @(0.3),
                                     @(0.5),
//                                     @(0.7),
                                     @(1)
                                     ];
        
        
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
        [_gradientLayer setEndPoint:CGPointMake(1, 1)];
    }
    return _gradientLayer;
}
@end
