//
//  PRMenueBGView.m
//  RefreshAnimation
//
//  Created by Weimob on 2019/5/28.
//  Copyright © 2019 com.shuxuan.fwex. All rights reserved.
//

#import "PRMenueBGView.h"
#import "RFMenueView.h"

@interface PRMenueBGView()

@property (nonatomic, strong) UIButton *menueBtn;

@property (nonatomic, strong) UILabel *msLable;

@property (nonatomic, strong) RFMenueView *rfMenueView;

@end


@implementation PRMenueBGView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.msLable];
        
        [self addSubview:self.menueBtn];
        CGPoint point = self.menueBtn.center;
        point.y = self.msLable.center.y;
        self.menueBtn.center = point;
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.rfMenueView = [[RFMenueView alloc] initWithFrame:CGRectMake(0, self.msLable.maxY, self.width, self.height - self.msLable.maxY)];
        
        [self addSubview:self.rfMenueView];
        
    }
    return self;
}

#pragma mark - sel
- (void)menueBtn:(UIButton *)button {
    
    button.selected = !button.selected;
    if (button.selected) {
        [self.rfMenueView startAnimation];
    } else {
        [self.rfMenueView stopAnimation];
    }
    
    
}

#pragma mark - lazy
- (UIButton *)menueBtn {
    
    if (!_menueBtn) {
        
        _menueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menueBtn.frame = CGRectMake(15, 0, 100, 40);
        [_menueBtn addTarget:self action:@selector(menueBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_menueBtn setTitle:@"打开" forState:UIControlStateNormal];
        [_menueBtn setTitle:@"关闭" forState:UIControlStateSelected];
    }
    return _menueBtn;
}

- (UILabel *)msLable {
    
    if (!_msLable) {
        
        _msLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, self.width, 100)];
        _msLable.backgroundColor = [UIColor orangeColor];
        _msLable.text = @"菜单栏";
        _msLable.font = [UIFont boldSystemFontOfSize:20];
        _msLable.textAlignment = NSTextAlignmentCenter;
    }
    return _msLable;
}


@end
