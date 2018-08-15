//
//  FactorView.m
//  RefreshAnimation
//
//  Created by xsd on 2018/8/8.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "FactorView.h"


@interface FactorView()

@property (nonatomic, strong) UIPanGestureRecognizer *swipGesture;

@property (nonatomic, strong) UIBezierPath *bezipath;//
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation FactorView

static inline CGPoint transfromPoint(CGPoint point,CGRect frame) {
    CGPoint returnPoint = point;
    
    returnPoint.y = CGRectGetHeight(frame) - point.y;
    returnPoint.x = CGRectGetWidth(frame) - point.x;
    
    return returnPoint;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"mew_baseline"].CGImage);
        
        _swipGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipRecognizer:)];
        
        [self addGestureRecognizer:_swipGesture];
        
        _bezipath = [UIBezierPath bezierPath];
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        self.shapeLayer.lineWidth = 0.5;
        
    }
    return self;
}

#pragma mark -


#pragma mark - action
- (void)handleSwipRecognizer:(UIPanGestureRecognizer *)recognize {
    
    CGPoint newPoint = [recognize locationInView:self];
    newPoint = transfromPoint(newPoint,self.frame);
    
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self handleAnimation:newPoint];
        }
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        default:
            break;
    }
    
    NSLog(@"point : ----!\t %@",[NSValue valueWithCGPoint:newPoint]);
}


- (void)handleAnimation:(CGPoint)point {
    
    //
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    CGPoint midPoint = CGPointApplyAffineTransform(point, transform);
    
    //这是x
    CGFloat xSqr = sqrt(midPoint.x * midPoint.x + midPoint.y * midPoint.y);
    
    CGFloat xP = (xSqr * xSqr) / midPoint.x;
    //计算y
    double degree = acos(midPoint.x/xSqr);
    
    CGFloat yP = xSqr / sin(degree);
    
    //这儿做一下限制！
    CGFloat scale = 1.0;
    
    if (xP > self.width) {
        //x
        scale = self.width/xP;
        xP = self.width;
        yP *= scale;
    } 
    
    CGPoint xPoint = CGPointMake(xP, 0);
    CGPoint yPoint = CGPointMake(0, yP);
    point = CGPointMake(point.x * scale, point.y * scale);
    
    xPoint = transfromPoint(xPoint,self.frame);
    yPoint = transfromPoint(yPoint,self.frame);
    point = transfromPoint(point,self.frame);
    
    //绘制一下...
    [self.bezipath removeAllPoints];
    [self.bezipath moveToPoint:xPoint];
    [self.bezipath addLineToPoint:yPoint];
    [self.bezipath addLineToPoint:point];
    [self.bezipath closePath];
    
    self.shapeLayer.path = self.bezipath.CGPath;
    
    [self.layer addSublayer:self.shapeLayer];
    
}

- (void)getImageFromAngle:(CGPoint)pointA pointB:(CGPoint)pointB {
    
    CGRect frame = CGRectMake(pointA.x, pointB.y, pointA.x, pointB.y);
    
    
}

- (void)stopAnimation {
    
}

@end
