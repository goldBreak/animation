//
//  AppDelegate.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/14.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *naviVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, k_screen_width, k_screen_high)];
    
    ViewController *vc = [[ViewController alloc] init];
    
    self.naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = self.naviVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
