//
//  Refresh2_Animation_View.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/14.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "Refresh2_Animation_View.h"
#import "Refreshh2_animation_layer.h"
#import "CoucltionAnimation.h"


@interface Refresh2_Animation_View()


@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UIView *customerView;

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, strong) Refreshh2_animation_layer *animationLayer;

@property (nonatomic, assign) CGFloat maxHigh;

@end

@implementation Refresh2_Animation_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:panGes];
        
        [self addSubview:self.customerView];
        
        _originFrame = self.customerView.frame;
        
        _maxHigh = 20;
        
        [self.layer addSublayer:self.animationLayer];
    }
    return self;
}

// 弄一个UIShaperLayer 计算一下path
#pragma mark - action
- (void)tapAction:(UIPanGestureRecognizer *)reconginzer {
    
    CGPoint nowPoint = [reconginzer translationInView:self];
    
    switch (reconginzer.state) {
        case UIGestureRecognizerStateChanged:
        {
            CGFloat currentDistance = (nowPoint.y / 2.0);
            
            CGRect frame = _originFrame;
            frame.origin.y += currentDistance;
            
            NSLog(@"!_________%g",nowPoint.y);
            if (nowPoint.y > 0) {
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.customerView.frame = frame;
                }];
                
                //factor
                currentDistance = MIN(currentDistance, _maxHigh);
                self.animationLayer.factor = currentDistance / _maxHigh;
                [self.animationLayer setNeedsDisplay];
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.customerView.frame = _originFrame;
            }];
            
            //self.animationLayer.radious = 30.;//self.animationLayer.maxRadious;
            if (nowPoint.y > 0) {
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"factor"];
                
                animation.values = [CoucltionAnimation animationValues:@(0.7) toValue:@(0) usingSpringWithDamping:2 initialSpringVelocity:5 duration:0.3];
                
                animation.fillMode = kCAFillModeForwards;
                
                self.animationLayer.factor = 0;
                
                [self.animationLayer addAnimation:animation forKey:@"animationTest"];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark - Lazy
- (UIView *)customerView {
    if (!_customerView) {
        _customerView = [[UIView alloc] initWithFrame:CGRectMake(0, 164, self.frame.size.width, self.frame.size.height - 164)];
        _customerView.backgroundColor = [UIColor colorWithRed:0.1 green:0.2 blue:0.1 alpha:1];
    }
    return _customerView;
}

- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        
        _shapeLayer = [CAShapeLayer layer];
        
        _shapeLayer.frame = CGRectMake(0, 64., k_screen_width, 100);
        
    }
    return _shapeLayer;
}

- (Refreshh2_animation_layer *)animationLayer {
    
    if (!_animationLayer) {
        _animationLayer = [[Refreshh2_animation_layer alloc] init];
        _animationLayer.frame = CGRectMake(0, 64, k_screen_width, self.frame.size.height);
        _animationLayer.factor = 0;
        [_animationLayer setNeedsDisplay];
    }
    return _animationLayer;
}

@end
