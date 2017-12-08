//
//  animationModel.h
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, animationType) {
    animationType_refresh,
    animationType_other,
};

@interface animationModel : NSObject<NSCopying>

@property (nonatomic, strong) NSString *nameString;

@property (nonatomic, strong) NSString *classNameStr;

@property (nonatomic, assign) animationType type;

@end
