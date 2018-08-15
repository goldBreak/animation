//
//  littleRedBookView.m
//  RefreshAnimation
//
//  Created by xsd on 2018/3/27.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "littleRedBookView.h"
#import "CoucltionAnimation.h"
#import "HafeLayer.h"

@interface littleRedBookView()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *contentLayer;

@property (nonatomic, strong) HafeLayer *upHalfLayer;
@property (nonatomic, strong) HafeLayer *downHalfLayer;

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
    
    NSArray *array = [CoucltionAnimation animationValues:@(0.7) toValue:@(0) usingSpringWithDamping:2 initialSpringVelocity:5 duration:time];
    NSMutableArray *resulst = [NSMutableArray array];
    for (NSInteger i = 0 ,count = array.count; i < count; i ++) {
        UIBezierPath *path = [self upHalfBezierPath];
        CGFloat loat[] = {(CGFloat)2.0,(CGFloat)[array[i] floatValue] * 10};
        [path setLineDash:loat count:2 phase:0];
        [resulst addObject:path];
    }
    return resulst;
}

- (NSMutableArray *)valueWithDuration:(CFTimeInterval)time {
    
    NSMutableArray *array = [NSMutableArray array];
    int numbersOfPoint = time * 30;
    CGFloat bangth = (self.upHalfLayer.bounds.size.width / 2. - 4) * M_PI;
    
    [array addObject:@(bangth)];
    
    for (int i = 1; i < numbersOfPoint; i ++) {
        bangth /= 2;
        [array addObject:@(bangth)];
    }
    NSMutableArray *result = [NSMutableArray array];
    for (int i = numbersOfPoint - 1; i >= 0 ; i --) {
        [result addObject:@[@(2),array[i]]];
    }
    return result;
}

- (void)buildAnimation {
    
    CFTimeInterval duration = 0.85;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue  = @(M_PI*2);

    CABasicAnimation *keyAnimation_ = [CABasicAnimation animationWithKeyPath:@"lineDashPattern"];
    keyAnimation_.fromValue = @[@2,@0];
    keyAnimation_.toValue = @[@2,@20];
    
    CAKeyframeAnimation *keyAnimaiton = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimaiton.values = [self valueWithDuration:duration path:nil fromValue:0 toValue:0   ];
    
    
    self.gropOne = [CAAnimationGroup animation];
    self.gropOne.animations = @[keyAnimaiton];
    self.gropOne.duration = duration;
    self.gropOne.delegate = self;
    self.gropOne.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.gropOne.removedOnCompletion = NO;
    self.gropOne.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *keyAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation1.values = [self valueWithDuration:duration path:self.downHalfBezierPath fromValue:60. toValue:0];
    
    self.gropOne1 = [CAAnimationGroup animation];
    self.gropOne1.animations = @[[rotationAnimation copy],keyAnimation1];
    self.gropOne1.duration = duration;
    self.gropOne1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.gropOne1.removedOnCompletion = NO;
    self.gropOne1.fillMode = kCAFillModeForwards;
    
    
    //group2
    CABasicAnimation *rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.fromValue = @(0);
    rotationAnimation1.toValue  = @(M_PI*2);
    
    CABasicAnimation *keyAnimation21 = [CABasicAnimation animationWithKeyPath:@"lineDashPattern"];
    keyAnimation21.fromValue = @[@2,@20];
    keyAnimation21.toValue = @[@2,@0];
    
//    CABasicAnimation *stokeAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    stokeAnimation1.fromValue = @0.2;
//    stokeAnimation1.toValue = @1;
    
    self.gropTwo = [CAAnimationGroup animation];
    self.gropTwo.animations = @[rotationAnimation1,keyAnimation21];
    self.gropTwo.duration = duration;
    self.gropTwo.delegate = self;
    self.gropTwo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.gropTwo.removedOnCompletion = NO;
    self.gropTwo.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *keyAnimation22 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation22.values = [self valueWithDuration:duration path:self.downHalfBezierPath fromValue:0 toValue:60];
    
    self.gropTwo2 = [CAAnimationGroup animation];
    self.gropTwo2.animations = @[[rotationAnimation1 copy],keyAnimation22];
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
//        self.upHalfLayer.strokeEnd = 0.2;
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
}

- (void)animationStepTwo {
    [self.upHalfLayer addAnimation:self.gropTwo forKey:@"step2"];
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
- (HafeLayer *)upHalfLayer {
    
    if (!_upHalfLayer) {
        
        _upHalfLayer = [HafeLayer layer];
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

- (HafeLayer *)downHalfLayer {
    if (!_downHalfLayer) {
        _downHalfLayer = [HafeLayer layer];
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
        _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(self.width - 100, 140, 50, 40)];
        [_switchBtn addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchBtn;
}
@end
