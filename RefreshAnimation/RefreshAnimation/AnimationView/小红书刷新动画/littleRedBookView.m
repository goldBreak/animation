//
//  littleRedBookView.m
//  RefreshAnimation
//
//  Created by xsd on 2018/3/27.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "littleRedBookView.h"

@interface littleRedBookView()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *contentLayer;

@property (nonatomic, strong) CAShapeLayer *upHalfLayer;
@property (nonatomic, strong) CAShapeLayer *downHalfLayer;

@property (nonatomic, strong) UIBezierPath *upHalfBezierPath;//上半个
@property (nonatomic, strong) UIBezierPath *downHalfBezierPath;//下半个

@property (nonatomic, strong) UISwitch *switchBtn;//控制on

@property (nonatomic, strong) CAAnimationGroup *gropOne;//上面的组合动画1.
@property (nonatomic, strong) CAAnimationGroup *gropOne1;//下面的组合动画1.


@property (nonatomic, strong) CAAnimationGroup *gropTwo;//上面的组合动画2.
@property (nonatomic, strong) CAAnimationGroup *gropTwo2;//下面的组合动画2.
@end

@implementation littleRedBookView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.switchBtn];
        [self.layer addSublayer:self.contentLayer];
        [self.contentLayer addSublayer:self.upHalfLayer];
//        [self.contentLayer addSublayer:self.downHalfLayer];
        [self buildAnimation];
    }
    return self;
}

#pragma mark - action
- (void)handleSwitch:(UISwitch *)siwtchSender {
    
    siwtchSender.on = !siwtchSender.on;
    
    if (siwtchSender.on) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }
}


- (NSMutableArray *)valueWithDuration:(CFTimeInterval)time path:(UIBezierPath *)path fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    
    //1秒30个！不要太多了
    NSInteger numbersOfPoint = time * 30;
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat d_value = toValue - fromValue;
    //分成10块！
    //blank  为  0 - d_value/10;
    //dash   为  d_value/10 - 0;
    CGFloat dash = d_value / 10;
    CGFloat blanks = dash / numbersOfPoint;
    CGFloat autoBlanks = 0;
    for (int i = 0; i < numbersOfPoint; i ++) {
        CGFloat a[2];
        if (fromValue > toValue) {
            a[0] = dash - autoBlanks;
            a[1] = autoBlanks;
        } else {
            a[0] = autoBlanks;
            a[1] = dash - autoBlanks;
        }
    
        [path setLineDash:a count:2 phase:0];
        [array addObject:(__bridge id)[[path copy] CGPath]];
        autoBlanks += blanks;
    }
    return nil;
}

- (void)buildAnimation {
    
    CFTimeInterval duration = 0.5;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue  = @(M_PI);
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.values = [self valueWithDuration:duration path:self.upHalfBezierPath fromValue:60 toValue:0];
    
    CABasicAnimation *stokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stokeAnimation.fromValue = @1;
    stokeAnimation.toValue = @0.2;
    
    self.gropOne = [CAAnimationGroup animation];
    self.gropOne.animations = @[rotationAnimation,keyAnimation,stokeAnimation];
    self.gropOne.duration = duration;
    self.gropOne.delegate = self;
    self.gropOne.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.gropOne.removedOnCompletion = NO;
    self.gropOne.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *keyAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation1.values = [self valueWithDuration:duration path:self.downHalfBezierPath fromValue:60. toValue:0];
    
    self.gropOne1 = [CAAnimationGroup animation];
    self.gropOne1.animations = @[[rotationAnimation copy],keyAnimation1,[stokeAnimation copy]];
    self.gropOne1.duration = duration;
    self.gropOne1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.gropOne1.removedOnCompletion = NO;
    self.gropOne1.fillMode = kCAFillModeForwards;
    
    
    //group2
    CABasicAnimation *rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.fromValue = @(M_PI);
    rotationAnimation1.toValue  = @(M_PI*2);
    
    CAKeyframeAnimation *keyAnimation21 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation21.values = [self valueWithDuration:duration path:self.upHalfBezierPath fromValue:0 toValue:60];
    
    CABasicAnimation *stokeAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stokeAnimation1.fromValue = @0.2;
    stokeAnimation1.toValue = @1;
    
    self.gropTwo = [CAAnimationGroup animation];
    self.gropTwo.animations = @[rotationAnimation1,keyAnimation21,stokeAnimation1];
    self.gropTwo.duration = duration;
    self.gropTwo.delegate = self;
    self.gropTwo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    self.gropTwo.removedOnCompletion = NO;
    self.gropTwo.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *keyAnimation22 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation22.values = [self valueWithDuration:duration path:self.downHalfBezierPath fromValue:0 toValue:60];
    
    self.gropTwo2 = [CAAnimationGroup animation];
    self.gropTwo2.animations = @[[rotationAnimation1 copy],keyAnimation22,[stokeAnimation1 copy]];
    self.gropTwo2.duration = duration;
    self.gropTwo2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    self.gropTwo2.removedOnCompletion = NO;
    self.gropTwo2.fillMode = kCAFillModeForwards;
    
}


- (void)startAnimation {
    [self animationStepOne];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    
    if ([anim isEqual:[self.upHalfLayer animationForKey:@"step1"]]) {
        //
//        [self.upHalfLayer removeAllAnimations];
//        [self.downHalfLayer removeAllAnimations];
        self.upHalfLayer.strokeEnd = 0.2;
        [self animationStepTwo];
    } else if([anim isEqual:[self.upHalfLayer animationForKey:@"step2"]]) {
        //
        [self.upHalfLayer removeAllAnimations];
        [self.downHalfLayer removeAllAnimations];
        [self animationStepOne];
    }
    
}

- (void)animationStepOne {
    [self.upHalfLayer addAnimation:self.gropOne forKey:@"step1"];
//    [self.downHalfLayer addAnimation:self.gropOne1 forKey:nil];
}

- (void)animationStepTwo {
    [self.upHalfLayer addAnimation:self.gropTwo forKey:@"step2"];
//    [self.downHalfLayer addAnimation:self.gropTwo2 forKey:nil];
}

- (void)stopAnimation {
    
    [self.upHalfLayer removeAllAnimations];
    [self.downHalfLayer removeAllAnimations];
    
}

- (UIBezierPath *)downHalfBezierPath {
    
    if (!_downHalfBezierPath) {
        _downHalfBezierPath = [UIBezierPath bezierPath];
        CGSize size = self.downHalfLayer.bounds.size;
        [_downHalfBezierPath addArcWithCenter:CGPointMake(size.width / 2., size.height / 2.) radius:(size.width / 2. - 4)  startAngle:0.2 endAngle:M_PI-0.2 clockwise:1];
        _downHalfBezierPath.lineCapStyle = kCGLineCapRound;
        _downHalfBezierPath.lineJoinStyle = kCGLineJoinRound;
    }
    
    return _downHalfBezierPath;
}

- (UIBezierPath *)upHalfBezierPath {
    
    if (!_upHalfBezierPath) {
        _upHalfBezierPath = [UIBezierPath bezierPath];
        CGSize size = self.upHalfLayer.bounds.size;
        [_upHalfBezierPath addArcWithCenter:CGPointMake(size.width / 2., size.height / 2.) radius:(size.width / 2. - 4)  startAngle:-0.2 endAngle:M_PI+0.2 clockwise:0];
        _upHalfBezierPath.lineCapStyle = kCGLineCapRound;
        _upHalfBezierPath.lineJoinStyle = kCGLineJoinRound;
    }
    
    return _upHalfBezierPath;
}

#pragma mark - lazy
- (CALayer *)contentLayer {
    if (!_contentLayer) {
        _contentLayer = [CALayer layer];
        _contentLayer.frame = CGRectMake(0, 0, 60., 60.);
        _contentLayer.position = CGPointMake(self.center.x, _contentLayer.position.y + 100.);
    }
    return _contentLayer;
}
- (CAShapeLayer *)upHalfLayer {
    
    if (!_upHalfLayer) {
        
        _upHalfLayer = [CAShapeLayer layer];
        _upHalfLayer.frame = _contentLayer.bounds;
        _upHalfLayer.path = self.upHalfBezierPath.CGPath;
        _upHalfLayer.lineWidth = 3.;
        _upHalfLayer.lineCap = kCALineCapRound;
        _upHalfLayer.lineJoin = kCALineJoinRound;
        _upHalfLayer.fillColor = [UIColor clearColor].CGColor;
        _upHalfLayer.strokeColor = [UIColor redColor].CGColor;
    }
    return _upHalfLayer;
}

- (CAShapeLayer *)downHalfLayer {
    if (!_downHalfLayer) {
        _downHalfLayer = [CAShapeLayer layer];
        _downHalfLayer.frame = _contentLayer.bounds;
        _downHalfLayer.path = self.downHalfBezierPath.CGPath;
        _downHalfLayer.lineWidth = 3.;
        _downHalfLayer.lineCap = kCALineCapRound;
        _downHalfLayer.lineJoin = kCALineJoinRound;
        _downHalfLayer.fillColor = [UIColor clearColor].CGColor;
        _downHalfLayer.strokeColor = [UIColor redColor].CGColor;
    }
    return _downHalfLayer;
}

- (UISwitch *)switchBtn {
    
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(self.width - 100, 80, 50, 40)];
        [_switchBtn addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchBtn;
}
@end
