//
//  animationModel.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "animationModel.h"

@implementation animationModel

- (id)copyWithZone:(NSZone *)zone {
    
    animationModel *animation = [animationModel new];
    animation.nameString = self.nameString;
    animation.classNameStr = self.classNameStr;
    animation.type = self.type;
    
    return animation;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"nameString is %@,classNameStr is %@,type is %lu",self.nameString,self.classNameStr,(unsigned long)self.type];
}


@end
