
//
//  bossRefreshView.m
//  RefreshAnimation
//
//  Created by xsd on 2018/1/9.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "bossRefreshView.h"

#define cycleRadious 6


@interface bossRefreshView()<UITableViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *refreshView;

@property (nonatomic, strong) CAShapeLayer *firstCycle;
@property (nonatomic, strong) CAShapeLayer *secondCycle;
@property (nonatomic, strong) CAShapeLayer *thirdCycle;
@property (nonatomic, strong) CAShapeLayer *fourthCycle;

@property (nonatomic, assign) BOOL endScrolled;
@end

@implementation bossRefreshView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.endScrolled = YES;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat progress = scrollView.contentOffset.y;
    if (progress > 0 || !self.endScrolled) {
        return;
    }
    [self setAnimation:progress];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
    if (scrollView.contentOffset.y < -self.refreshView.bounds.size.height * 2) {
        self.endScrolled = NO;
        [self refreshAnimation];
    } else {
        self.endScrolled = YES;
    }
    
}

#pragma mark-
- (void)setAnimation:(CGFloat)progress {
    //
    CGFloat offsetY = -progress;
    if (offsetY < self.refreshView.bounds.size.height) {
        return;
    }
    
    CGFloat progree = self.refreshView.bounds.size.height / 4.0;
    //一个height内完成所有的中间动画！所以分1/4
    CGFloat offset = offsetY - self.refreshView.bounds.size.height;
    //#CGFloat maxHeight = self.bounds.size.height - cycleRadious;
    //NSLog(@"offset y is %g",offset);
    if (offset < progree) {
        [self.secondCycle setStrokeStart:0];
        [self.secondCycle setStrokeEnd:offset / progree];
        
        [self.thirdCycle setStrokeStart:0.0];
        [self.thirdCycle setStrokeEnd:0.0];
        
    } else if (offset < progree * 2) {
        
        [self.secondCycle setStrokeStart:0.99];
        [self.secondCycle setStrokeEnd:1];
        
        [self.thirdCycle setStrokeStart:0.0];
        [self.thirdCycle setStrokeEnd:(offset - progree) / progree];
        
        [self.fourthCycle setStrokeStart:0.0];
        [self.fourthCycle setStrokeEnd:0.0];
        
    } else if (offset < progree * 3) {
        [self.secondCycle setStrokeStart:0.99];
        [self.secondCycle setStrokeEnd:1];
        
        [self.thirdCycle setStrokeStart:0.99];
        [self.thirdCycle setStrokeEnd:1];
        
        [self.fourthCycle setStrokeStart:0.0];
        [self.fourthCycle setStrokeEnd:(offset - progree * 2) / progree];
        
    } else {
        [self.secondCycle setStrokeStart:0.99];
        [self.secondCycle setStrokeEnd:1];
        
        [self.thirdCycle setStrokeStart:0.99];
        [self.thirdCycle setStrokeEnd:1];
        
        [self.fourthCycle setStrokeStart:0.99];
        [self.fourthCycle setStrokeEnd:1];
    }
    
}

#pragma mark - animation
- (void)refreshAnimation {
    //
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 1.2;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.6);
    scaleAnimation.toValue = @(1);
    scaleAnimation.duration = 0.6;
    scaleAnimation.autoreverses = YES;
    
    CAAnimationGroup *gropAnimation = [CAAnimationGroup animation];
    gropAnimation.animations = @[rotationAnimation,scaleAnimation];
    gropAnimation.duration = 1.2;
    gropAnimation.repeatCount = CGFLOAT_MAX;
    
    [self.firstCycle addAnimation:gropAnimation forKey:@"animation_test"];
    [self.secondCycle addAnimation:[gropAnimation copy] forKey:@"animation_test1"];
    [self.thirdCycle addAnimation:[gropAnimation copy] forKey:@"animation_test2"];
    [self.fourthCycle addAnimation:[gropAnimation copy] forKey:@"animation_test3"];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(self.refreshView.bounds.size.height * 2, 0, 0, 0)];
    
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:3];
    
}

- (void)stopAnimation {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    } completion:^(BOOL finished) {
        
        [self.secondCycle setStrokeStart:0.0];
        [self.secondCycle setStrokeEnd:0.0];
        
        [self.thirdCycle setStrokeStart:0.0];
        [self.thirdCycle setStrokeEnd:0.0];
        
        [self.fourthCycle setStrokeStart:0.0];
        [self.fourthCycle setStrokeEnd:0.0];
        
        [self.firstCycle removeAllAnimations];
        [self.secondCycle removeAllAnimations];
        [self.thirdCycle removeAllAnimations];
        [self.fourthCycle removeAllAnimations];
        self.endScrolled = YES;
    }];
    
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.endScrolled = YES;
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = self.frame;
        
        frame.origin.y = 64.0;
        frame.size.height -= 64.;
        
        _tableView = [[UITableView alloc] initWithFrame:frame];
        _tableView.rowHeight = 44.;
        _tableView.delegate = self;
        [_tableView addSubview:self.refreshView];
        
#pragma mark - 添加四个shapeLayer
        [self.refreshView.layer addSublayer:self.firstCycle];
        [self.refreshView.layer addSublayer:self.secondCycle];
        [self.refreshView.layer addSublayer:self.thirdCycle];
        [self.refreshView.layer addSublayer:self.fourthCycle];
        
    }
    return _tableView;
}

#pragma mark - Lazy
- (UIView *)refreshView {
    
    if (!_refreshView) {
        _refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, self.frame.size.width, 40)];
        _refreshView.backgroundColor = [UIColor clearColor];
    }
    return _refreshView;
}

- (CAShapeLayer *)firstCycle {
    
    if (!_firstCycle) {
        _firstCycle = [CAShapeLayer layer];
        _firstCycle.frame = CGRectMake(0, 0, CGRectGetHeight(self.refreshView.frame), CGRectGetHeight(self.refreshView.frame));
        _firstCycle.position = CGPointMake(self.center.x, _firstCycle.bounds.size.height / 2);
        
        //添加cell
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(CGRectGetWidth(_firstCycle.frame) / 2., cycleRadious) radius:cycleRadious startAngle:0 endAngle:M_PI * 2 clockwise:1];
        [_firstCycle setFillColor:[UIColor redColor].CGColor];
        [_firstCycle setPath:path.CGPath];
    }
    return _firstCycle;
}

- (CAShapeLayer *)secondCycle {
    if (!_secondCycle) {
        _secondCycle = [CAShapeLayer layer];
        _secondCycle.frame = self.firstCycle.bounds;
        _secondCycle.position = self.firstCycle.position;
        
        //添加path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(_firstCycle.frame) / 2., cycleRadious)];
        [path addLineToPoint:CGPointMake(cycleRadious, CGRectGetHeight(_firstCycle.frame) / 2.)];
        
        //
        [_secondCycle setPath:path.CGPath];
        [_secondCycle setStrokeColor:[UIColor greenColor].CGColor];
        [_secondCycle setLineWidth:cycleRadious * 2];
        [_secondCycle setLineCap:kCALineCapRound];
        [_secondCycle setLineJoin:kCALineJoinRound];
        [_secondCycle setStrokeEnd:0];
    }
    return _secondCycle;
}

- (CAShapeLayer *)thirdCycle {
    
    if (!_thirdCycle) {
        _thirdCycle = [CAShapeLayer layer];
        _thirdCycle.frame = self.firstCycle.bounds;
        _thirdCycle.position = self.firstCycle.position;
        
        //添加path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(cycleRadious, CGRectGetHeight(_firstCycle.frame) / 2.)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(_firstCycle.frame) / 2., CGRectGetHeight(_firstCycle.frame) - cycleRadious)];
        
        //
        [_thirdCycle setPath:path.CGPath];
        [_thirdCycle setStrokeColor:[UIColor blueColor].CGColor];
        [_thirdCycle setLineWidth:cycleRadious * 2];
        [_thirdCycle setLineCap:kCALineCapRound];
        [_thirdCycle setLineJoin:kCALineJoinRound];
        
        [_thirdCycle setStrokeEnd:0];
    }
    return _thirdCycle;
}

- (CAShapeLayer *)fourthCycle {
    
    if (!_fourthCycle) {
        _fourthCycle = [CAShapeLayer layer];
        _fourthCycle.frame = self.firstCycle.bounds;
        _fourthCycle.position = self.firstCycle.position;
        
        //添加path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(_firstCycle.frame) / 2., CGRectGetHeight(_firstCycle.frame) - cycleRadious)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(_firstCycle.frame) - cycleRadious, CGRectGetHeight(_firstCycle.frame) / 2.)];
        
        //
        [_fourthCycle setPath:path.CGPath];
        [_fourthCycle setStrokeColor:[UIColor purpleColor].CGColor];
        [_fourthCycle setLineWidth:cycleRadious * 2];
        [_fourthCycle setLineCap:kCALineCapRound];
        [_fourthCycle setLineJoin:kCALineJoinRound];
        [_fourthCycle setStrokeEnd:0];
    }
    return _fourthCycle;
}

@end
