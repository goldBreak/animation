//
//  QQRefreshLayer.m
//  RefreshAnimation
//
//  Created by xsd on 2017/12/19.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "QQRefreshLayer.h"

@interface QQRefreshLayer()


@end

@implementation QQRefreshLayer

+ (BOOL)needsDisplayForKey:(NSString *)key {
    
    if ([key isEqualToString:@"contextOffset"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    CGFloat offsetY = -self.contextOffset;
    CGFloat contentOff = 0.0;
    CGFloat bigRadious = 15.0;
    CGFloat smallRadious = 15.0;
    
    if (offsetY < 30.0) {
        // 小于15.0的就让他随着走
        contentOff = 0.0;
    } else if (offsetY < 50) {
        //小于高度的一半
        contentOff = offsetY - 15.0 * 2;//直径
        CGFloat maxHeight = CGRectGetHeight(self.frame) - 15.0 * 2;
        
        smallRadious -= contentOff / maxHeight * smallRadious;
        if (smallRadious < 5) {
            smallRadious = 5;
        }
    } else if(offsetY < CGRectGetHeight(self.frame)) {
        //小于高度
        contentOff = offsetY - 15.0 * 2;//直径
        CGFloat maxHeight = CGRectGetHeight(self.frame) - 15.0 * 2;
        
        smallRadious -= contentOff / maxHeight * smallRadious;
        if (smallRadious < 5) {
            smallRadious = 5;
        }
        
    } else {
        //处理其他情况
        contentOff = CGRectGetHeight(self.frame) - 15.0 * 2;//直径
        smallRadious = 5;
    }
    
    if (smallRadious < 13) {
        //给上面的最大的圆形加一个渐减的效果
        bigRadious = 15 - (15 - smallRadious) / 3.;
        if (bigRadious < 10) {
            bigRadious = 10;
        }
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //上半个圆！
    [path addArcWithCenter:CGPointMake(self.position.x, CGRectGetHeight(self.frame) - bigRadious - contentOff) radius:bigRadious startAngle:0 endAngle:M_PI clockwise:0];
    
    //连接线！// big
    [path addLineToPoint:CGPointMake(self.position.x + bigRadious, CGRectGetHeight(self.frame) - bigRadious - contentOff)];
    [path addLineToPoint:CGPointMake(self.position.x + smallRadious, CGRectGetHeight(self.frame) - smallRadious)];
    
    //下半个圆！
    [path addArcWithCenter:CGPointMake(self.position.x, CGRectGetHeight(self.frame) - smallRadious) radius:smallRadious startAngle:0 endAngle:M_PI  clockwise:1];
    [path closePath];
    
    [path addLineToPoint:CGPointMake(self.position.x - smallRadious, CGRectGetHeight(self.frame) - smallRadious)];
    [path addLineToPoint:CGPointMake(self.position.x - bigRadious, CGRectGetHeight(self.frame) - bigRadious - contentOff)];
    
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
}


@end
