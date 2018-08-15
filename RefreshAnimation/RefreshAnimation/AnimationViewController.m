//
//  AnimationViewController.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "AnimationViewController.h"
#import "BasicView.h"

@interface AnimationViewController ()

@property (nonatomic, strong) BasicView *customerView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)setClassName:(NSString *)className {
    
    _className = className;
    
    Class viewClass = NSClassFromString(className);
    
    CGRect frame = self.view.frame;
    
    _customerView = [[viewClass alloc] initWithFrame:frame];
    
    [self.view addSubview:_customerView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_customerView stopAnimation];
}

- (void)dealloc {
    
    NSLog(@"animationVC did dealloc");
}

@end
