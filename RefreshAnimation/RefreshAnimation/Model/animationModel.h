//
//  animationModel.h
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, animationType) {
    animationType_refresh,    /* 刷新动画 !*/
    animationType_Dynaic,  /* 动力学动画 !*/
    animationType_other,     /* 其他的类型 !*/
};

@interface animationModel : NSObject<NSCopying>

@property (nonatomic, strong) NSString *nameString;

@property (nonatomic, strong) NSString *classNameStr;

@property (nonatomic, assign) animationType type;

@end
