//
//  QQRefresh_animation_View.m
//  RefreshAnimation
//
//  Created by xsd on 2017/12/19.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "QQRefresh_animation_View.h"
#import "QQRefreshLayer.h"

@interface QQRefresh_animation_View()<UIScrollViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) QQRefreshLayer *refreshLayer;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation QQRefresh_animation_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.lable];
        [self.scrollView addSubview:self.headerView];
        [self.headerView.layer addSublayer:self.refreshLayer];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_canScroll) {
        CGPoint offsetPoint = scrollView.contentOffset;
        if (offsetPoint.y >= 0) {
            return;
        } else {
            self.refreshLayer.contextOffset = offsetPoint.y;
            [self.refreshLayer setNeedsDisplay];
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _canScroll = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    _canScroll = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contextOffset"];
    animation.duration = 0.3;
    animation.fromValue = @(scrollView.contentOffset.y);
    animation.toValue   = @(0);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.refreshLayer addAnimation:animation forKey:@"time"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.refreshLayer removeAllAnimations];
}


#pragma mark - Lazy
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
    
        CGRect frame = self.frame;

        frame.origin.y = 64.0;
        frame.size.height -= 64.;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height + 0.5);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _lable.text = @"下拉刷新";
        _lable.textColor = [UIColor blackColor];
        _lable.textAlignment = NSTextAlignmentCenter;
    }
    return _lable;
}

- (QQRefreshLayer *)refreshLayer {
    if (!_refreshLayer) {
        _refreshLayer = [QQRefreshLayer layer];
        _refreshLayer.frame = self.headerView.bounds;
        _refreshLayer.contextOffset = 0.0;
        [self.refreshLayer setNeedsDisplay];
    }
    return _refreshLayer;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, self.frame.size.width, 100)];
    }
    return _headerView;
}

- (void)dealloc {
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
