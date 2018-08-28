//
//  DynanicDemo.m
//  RefreshAnimation
//
//  Created by xsd on 2018/8/15.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "DynanicDemo.h"
@interface DynanicDemo()

@property (nonatomic, strong) UIView *viewOne;//1号
@property (nonatomic, strong) UIView *viewTwo;//2号

@property (nonatomic, strong) UIDynamicAnimator *animatior;

@property (nonatomic, strong) UISnapBehavior *snap;

@property (nonatomic, strong) UILabel *lable;

@end

@implementation DynanicDemo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.lable];
        [self addSubview:self.viewOne];
        
        self.viewOne.center = CGPointMake(self.viewOne.center.x, self.center.y);
        
        [self addSubview:self.viewTwo];
        self.viewTwo.center = CGPointMake(self.viewTwo.center.x, self.center.y);
        
        self.snap = [[UISnapBehavior alloc]initWithItem:self.viewOne snapToPoint:CGPointMake(100, 100)];
        //减震
        self.snap.damping = 0.6;
        
        [self.animatior removeAllBehaviors];
        [self.animatior addBehavior:self.snap];//添加新的行为

    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    if (@available(iOS 9.0, *)) {
        self.snap.snapPoint = point;
    } else {
        // Fallback on earlier versions
    }
    
}


#pragma mark - behaior
- (UIDynamicAnimator *)animatior {
    if (!_animatior) {
        _animatior = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return _animatior;
}

#pragma mark - ui
- (UIView *)viewOne {
    
    if (!_viewOne) {
        
        _viewOne = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 50, 50)];
        _viewOne.layer.borderColor = [UIColor blackColor].CGColor;
        _viewOne.layer.borderWidth = 1.0;
        UILabel *lable = [[UILabel alloc] initWithFrame:_viewOne.bounds];
        lable.text = @"1";
        lable.font = [UIFont systemFontOfSize:30];
        lable.textColor = [UIColor greenColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [_viewOne addSubview:lable];
    }
    return _viewOne;
}

- (UIView *)viewTwo {
    
    if (!_viewTwo) {
        _viewTwo = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 50)];
        _viewTwo.layer.borderColor = [UIColor blackColor].CGColor;
        _viewTwo.layer.borderWidth = 1.0;
        _viewTwo.userInteractionEnabled = NO;
        UILabel *lable = [[UILabel alloc] initWithFrame:_viewTwo.bounds];
        lable.text = @"2";
        lable.font = [UIFont systemFontOfSize:30];
        lable.textColor = [UIColor greenColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [_viewTwo addSubview:lable];
    }
    return _viewTwo;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.width, 15.)];
        _lable.text = @"tap anywhere you like ,look at the animation.";
        _lable.textColor = [UIColor whiteColor];
        _lable.font = [UIFont systemFontOfSize:12.];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.userInteractionEnabled = NO;
    }
    return  _lable;
}
@end
