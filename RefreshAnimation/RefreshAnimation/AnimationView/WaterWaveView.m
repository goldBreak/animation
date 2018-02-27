//
//  WaterWaveView.m
//  RefreshAnimation
//
//  Created by xsd on 2018/2/27.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView()
{
    CGFloat firstSpeed;
    CGFloat secondSpeed;
    
    CGFloat firstOffset;
    CGFloat secondOffset;
}

@property (nonatomic, strong) UISwitch *animationSwitch;

@property (nonatomic, strong) UIView *beachView;
@property (nonatomic, strong) UIView *waterView;
@property (nonatomic, strong) UIView *waveView;

@property (nonatomic, strong) CAShapeLayer *waveLayer_one;
@property (nonatomic, strong) CAShapeLayer *waveLayer_two;

@property (nonatomic, strong) CADisplayLink *disLink;

@end

@implementation WaterWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        firstSpeed = 0.95;
        secondSpeed = 0.8;
        firstOffset = 20;
        secondOffset = 0;
        
        [self addSubview:self.animationSwitch];
        
        [self addSubview:self.beachView];
        [self addSubview:self.waterView];
        [self addSubview:self.waveView];
        
        [self.waveView.layer addSublayer:self.waveLayer_one];
        [self.waveView.layer addSublayer:self.waveLayer_two];
        
        CGPathRef firstPath = [self getgetCurrentWavePathOffset:firstOffset height:20];
        CGPathRef secondPath = [self getgetCurrentWavePathOffset:secondOffset height:23];
        
        self.waveLayer_one.path = firstPath;
        self.waveLayer_two.path = secondPath;
        
        CGPathRelease(firstPath);
        CGPathRelease(secondPath);
    }
    return self;
}
- (void)removeFromSuperview {
    [self.disLink invalidate];
    self.disLink = nil;
}

#pragma mark - action
- (void)handleWaterAction:(UISwitch *)sender {
    //
    if (sender.on) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }
}

- (void)startAnimation {
    
    [self.disLink description];
}

- (void)stopAnimation {
    [self.disLink invalidate];
    self.disLink = nil;
}

- (void)handleDislink:(CADisplayLink *)link {
   
    firstOffset += firstSpeed;
    secondOffset += secondSpeed;
    CGPathRef firstPath = [self getgetCurrentWavePathOffset:firstOffset height:20];
    CGPathRef secondPath = [self getgetCurrentWavePathOffset:secondOffset height:23];
    
    self.waveLayer_one.path = firstPath;
    self.waveLayer_two.path = secondPath;
    
    CGPathRelease(firstPath);
    CGPathRelease(secondPath);
}

- (CGPathRef)getgetCurrentWavePathOffset:(CGFloat)offset height:(CGFloat)high {
    
    CGFloat width = self.waveView.width;
    CGFloat height = 6;
    
    CGMutablePathRef myPath = CGPathCreateMutable();
    CGPathMoveToPoint(myPath, nil, 0, height);
    CGFloat y = 0.0f;
    
    for (float x = 0.0f; x <=  self.waveView.width ; x++) {
        y = height * sinf((360/width) *(x * M_PI / 180) - offset * M_PI / 180) + high;
        CGPathAddLineToPoint(myPath, nil, x, y);
    }
    
    CGPathAddLineToPoint(myPath, nil, width, self.waveView.frame.size.height);
    CGPathAddLineToPoint(myPath, nil, 0, self.waveView.frame.size.height);
    
    CGPathCloseSubpath(myPath);
    
    return myPath;
}

#pragma mark - lazy
- (UIView *)beachView {
    
    if (!_beachView) {
        
        _beachView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, k_screen_width, 100)];
        
        //设置一个渐变色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = _beachView.bounds;
        [gradientLayer setColors:@[
                                   (__bridge id)[UIColor colorWithRed:0.7 green:0.6 blue:0.1 alpha:1].CGColor,
                                   (__bridge id)[UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1].CGColor
                                   ]];
        
        [gradientLayer setStartPoint:CGPointMake(0, 0)];
        [gradientLayer setEndPoint:CGPointMake(1, 0)];
        [_beachView.layer addSublayer:gradientLayer];
    }
    return _beachView;
}

- (UIView *)waveView {
    if (!_waveView) {
        _waveView = [[UIView alloc] initWithFrame:CGRectMake(0, self.beachView.maxY-40, k_screen_width, 40)];
        _waveView.backgroundColor = [UIColor clearColor];
    }
    return _waveView;
}

- (UIView *)waterView {
    if (!_waterView) {
        _waterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.waveView.maxY-2, k_screen_width, 200)];
        _waterView.backgroundColor = [UIColor whiteColor];
    }
    return _waterView;
}

- (CAShapeLayer *)waveLayer_one {
    if (!_waveLayer_one) {
        _waveLayer_one = [CAShapeLayer layer];
        _waveLayer_one.frame = self.waveView.bounds;
        _waveLayer_one.fillColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    }
    return _waveLayer_one;
}
- (CAShapeLayer *)waveLayer_two {
    if (!_waveLayer_two) {
        _waveLayer_two = [CAShapeLayer layer];
        _waveLayer_two.frame = self.waveView.bounds;
        _waveLayer_two.fillColor = [UIColor whiteColor].CGColor;
    }
    return _waveLayer_two;
}

- (UISwitch *)animationSwitch {
    
    if (!_animationSwitch) {
        
        _animationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.width - 100, 80, 50, 40)];
        [_animationSwitch addTarget:self action:@selector(handleWaterAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _animationSwitch;
}

- (CADisplayLink *)disLink {
    
    if (!_disLink) {
        
        _disLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDislink:)];
        [_disLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _disLink;
}
@end
