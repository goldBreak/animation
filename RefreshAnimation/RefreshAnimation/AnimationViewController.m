//
//  AnimationViewController.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIView *customerView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)setClassName:(NSString *)className {
    _className = className;
    
    Class viewClass = NSClassFromString(className);
    _customerView = [[viewClass alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:_customerView];
}

@end
