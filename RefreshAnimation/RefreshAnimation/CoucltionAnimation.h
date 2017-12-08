//
//  CoucltionAnimation.h
//  RefreshAnimation
//
//  Created by xsd on 2017/11/15.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CoucltionAnimation : NSObject

+(NSMutableArray *) animationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration;

@end
