//
//  RaindropViewLayer.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "RaindropViewLayer.h"

@interface RaindropViewLayer()

@property (nonatomic, assign) CGFloat radious;
@property (nonatomic, assign) CGFloat minRadious;
@property (nonatomic, strong) UIColor *indiaColor;
@end

@implementation RaindropViewLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _radious = 100.0;
        _minRadious = _radious / 4.0;
        _indiaColor = [UIColor lightTextColor];
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    
    if ([key isEqualToString:@"animationOffset"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    //draw in context layer-------!-------
    
    [super drawInContext:ctx];
    _radious = 100.0;
    _minRadious = _radious / 4.0;
    _indiaColor = [UIColor lightTextColor];
    
    CGPoint center = self.position;
    CGFloat originY = sqrt(2) / 2 * _radious;
    CGFloat offset = self.animationOffset * self.minRadious;
    
    CGPoint aCenter = CGPointMake(center.x - _radious / 2., center.y - originY);
    CGPoint bCenter = CGPointMake(aCenter.x + _radious, aCenter.y);
    
    //control point!
    CGPoint controlPoint1 = CGPointMake(center.x - offset, aCenter.y);
    CGPoint controlPoint2 = CGPointMake(controlPoint1.x - _minRadious , aCenter.y);
    CGPoint controlPoint3 = CGPointMake(controlPoint1.x + _minRadious , aCenter.y);
    
    CGPoint controlPoint11 = CGPointMake(aCenter.x + (controlPoint2.x - aCenter.x) / 2., aCenter.y - (controlPoint2.x - aCenter.x) / 2.);
    CGPoint controlPoint21 = CGPointMake(controlPoint2.x + (controlPoint1.x - controlPoint2.x) / 2., aCenter.y + _minRadious);
    CGPoint controlPoint31 = CGPointMake(controlPoint1.x + (controlPoint3.x - controlPoint1.x) / 2., aCenter.y - _minRadious);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:aCenter];
    

    [path addQuadCurveToPoint:controlPoint2 controlPoint:controlPoint11];
    [path addQuadCurveToPoint:controlPoint1 controlPoint:controlPoint21];
    [path addQuadCurveToPoint:controlPoint3 controlPoint:controlPoint31];
     
    [path addQuadCurveToPoint:bCenter controlPoint:CGPointMake(controlPoint3.x + (bCenter.x - controlPoint3.x) / 2., aCenter.y + _minRadious)];
    
    [path addArcWithCenter:center radius:_radious startAngle:-M_PI / 3 endAngle:4 * M_PI / 3 clockwise:YES];
    
//    [path fill];

    CGContextSetFillColorWithColor(ctx, _indiaColor.CGColor);
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
    
}

@end
