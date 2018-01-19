//
//  Refreshh2_animation_layer.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/15.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//


#import "Refreshh2_animation_layer.h"

#define k_screenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

@interface Refreshh2_animation_layer()

@property (nonatomic, assign) CGPoint pointA;
@property (nonatomic, assign) CGPoint pointB;
@property (nonatomic, assign) CGPoint pointC;
@property (nonatomic, assign) CGPoint pointD;
@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) CGFloat radious;
@property (nonatomic, strong) UIColor *indiaColor;

@end


@implementation Refreshh2_animation_layer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.backgroundColor = [UIColor lightGrayColor].CGColor;
        
        self.pointA = CGPointMake(k_screenWidth / 2, 30.0);
        self.maxRadious = 15.0;
        self.radious = self.maxRadious;
        //        _radious = 30.0;
        self.pointB = CGPointMake(k_screenWidth / 2 + _radious, 30.0 +_radious);
        self.pointC = CGPointMake(_pointA.x, 30.0 + _radious * 2);
        self.pointD = CGPointMake(k_screenWidth / 2 - _radious, 30.0 + _radious);
        
        _indiaColor = [UIColor blackColor];
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"radious"]) {
        return YES;
    }
    if ([key isEqualToString:@"factor"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

#pragma mark
- (void)drawInContext:(CGContextRef)ctx {
    
    [super drawInContext:ctx];
    //绘制一个圆形啊图案
    
    _radious = 15.0;
    
    CGFloat extra = (_radious * 2.0 * 2.0 / 5.0) * _factor;
    
    self.pointA = CGPointMake(k_screenWidth / 2, 30.0 + extra);
    self.pointB = CGPointMake(k_screenWidth / 2 + _radious - extra, 30.0 +_radious + extra);
    self.pointC = CGPointMake(_pointA.x, 30.0 + _radious * 2 + extra * 2);
    self.pointD = CGPointMake(k_screenWidth / 2 - _radious + extra, 30.0 + _radious);
    
    _offset = 2 * _radious / 3.6;
    
    CGPoint a11 = CGPointMake(_pointA.x + _offset, _pointA.y);
    CGPoint a12 = CGPointMake(_pointB.x, _pointB.y - _offset);
    
    CGPoint a21 = CGPointMake(_pointB.x, _pointB.y + _offset);
    CGPoint a22 = CGPointMake(_pointC.x + _offset, _pointC.y);
    
    CGPoint a31 = CGPointMake(_pointC.x - _offset, _pointC.y);
    CGPoint a32 = CGPointMake(_pointD.x, _pointD.y + _offset);
    
    CGPoint a41 = CGPointMake(_pointD.x, _pointD.y - _offset);
    CGPoint a42 = CGPointMake(_pointA.x - _offset, _pointA.y);
    
    UIBezierPath *bezipath = [UIBezierPath bezierPath];
    [bezipath moveToPoint:_pointA];
    [bezipath addCurveToPoint:_pointB controlPoint1:a11 controlPoint2:a12];
    [bezipath addCurveToPoint:_pointC controlPoint1:a21 controlPoint2:a22];
    [bezipath addCurveToPoint:_pointD controlPoint1:a31 controlPoint2:a32];
    [bezipath addCurveToPoint:_pointA controlPoint1:a41 controlPoint2:a42];
    [bezipath closePath];
    
    CGContextSetFillColorWithColor(ctx, _indiaColor.CGColor);
    CGContextAddPath(ctx, bezipath.CGPath);
    CGContextFillPath(ctx);
    
}

@end
