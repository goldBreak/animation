//
//  CoucltionAnimation.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/15.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "CoucltionAnimation.h"

@implementation CoucltionAnimation

+ (NSMutableArray *) animationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration{
    
    //60个关键帧
    NSInteger numOfPoints  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfPoints];
    for (NSInteger i = 0; i < numOfPoints; i++) {
        [values addObject:@(0.0)];
    }
    
    //差值
    CGFloat d_value = [toValue floatValue] - [fromValue floatValue];
    
    for (NSInteger point = 0; point<numOfPoints; point++) {
        
        CGFloat x = (CGFloat)point / (CGFloat)numOfPoints;
        CGFloat value = [toValue floatValue] - d_value * (pow(M_E, -damping * x) * cos(velocity * x)); //1 y = 1-e^{-5x} * cos(30x)
        
        values[point] = @(value);
    }
    
    return values;
    
}

@end
