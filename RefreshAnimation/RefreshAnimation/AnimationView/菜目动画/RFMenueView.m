//
//  RFMenueView.m
//  RefreshAnimation
//
//  Created by Weimob on 2019/5/28.
//  Copyright © 2019 com.shuxuan.fwex. All rights reserved.
//

#import "RFMenueView.h"

@interface RFMenueView()

@property (nonatomic, strong) UIBezierPath *beziPath;

@property (nonatomic, strong) CAShapeLayer *shapLayer;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, strong) NSMutableArray *originCenters;

@end


@implementation RFMenueView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _shapLayer = [CAShapeLayer layer];
        _shapLayer.path = self.beziPath.CGPath;
        _shapLayer.lineWidth = 50.0;
        [_shapLayer setStrokeColor:[UIColor orangeColor].CGColor];
        [_shapLayer setFillColor:[UIColor clearColor].CGColor];
        _shapLayer.lineCap = kCALineCapRound;
        _shapLayer.strokeEnd = 0;
        
        [self.layer addSublayer:_shapLayer];
        
        NSArray *imgName = @[@"icon_mess",
                             @"icon_print",
                             @"icon_safe",
                             @"icon_us"];
        
        CGFloat deGreed = M_PI / (imgName.count + 1);
        CGFloat preDegree = deGreed;
        
        for (NSInteger i = 0; i < imgName.count; i ++) {
        
            preDegree = deGreed * (i + 1);
            
            NSString *img = imgName[i];
            UIImage *image = [UIImage imageNamed:img];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
            button.frame = imageV.frame;
            [button setImage:image forState:UIControlStateNormal];
            
            [self.originCenters addObject:@(preDegree)];
            
            button.center = [self convertDegree:preDegree radius:( self.width / 2.0 - 30.0 )];
            
//            button.layer.anchorPoint = CGPointMake(self.width/2.0, 0);
            
            [self addSubview:button];
            
            [self.dataSources addObject:button];
        }
        
        
        
    }
    return self;
}


#pragma mark - point 转换
- (CGPoint)convertDegree:(CGFloat)degree radius:(CGFloat)radius{
    
    CGPoint returnPoint = CGPointZero;
    
    CGFloat pointx = radius * cos(degree);
    CGFloat pointy = radius * sin(degree);
    
    if (radius  <= M_PI_2) {
        pointx = self.width / 2. - pointx;
    } else {
        pointx = self.width / 2. + pointx;
    }
    
    returnPoint = CGPointMake(pointx, pointy);
    
    return returnPoint;
}


#pragma mark - animation
- (void)startAnimation {
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    CABasicAnimation *shapAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    shapAnimation.fromValue = @0;
    shapAnimation.toValue = @1;
    shapAnimation.duration = 0.5;
    shapAnimation.removedOnCompletion = NO;
    shapAnimation.fillMode = kCAFillModeForwards;
    [self.shapLayer addAnimation:shapAnimation forKey:@"shapAnimation"];
    
}

- (void)stopAnimation {
    //close animation
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.shapLayer removeAllAnimations];
    
    CABasicAnimation *shapAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    shapAnimation.fromValue = @1;
    shapAnimation.toValue = @0;
    shapAnimation.duration = 0.5;
    shapAnimation.additive = YES;
    shapAnimation.removedOnCompletion = NO;
    shapAnimation.fillMode = kCAFillModeForwards;
    [self.shapLayer addAnimation:shapAnimation forKey:@"shapAnimation"];
}

#pragma mark - lazy
- (UIBezierPath *)beziPath {
    
    if (!_beziPath) {
    
        _beziPath = [UIBezierPath bezierPath];
        [_beziPath addArcWithCenter:CGPointMake(self.width/2., 0) radius:self.width/2. - 25. startAngle:M_PI endAngle:0 clockwise:NO];
    }
    return _beziPath;
}

- (NSMutableArray *)dataSources {
    
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (NSMutableArray *)originCenters {
    
    if (!_originCenters) {
        _originCenters = [NSMutableArray array];
    }
    return _originCenters;
}

@end
