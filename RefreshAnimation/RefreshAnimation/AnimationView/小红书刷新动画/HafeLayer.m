//
//  HafeLayer.m
//  RefreshAnimation
//
//  Created by xsd on 2018/4/12.
//  Copyright © 2018年 com.shuxuan.fwex. All rights reserved.
//

#import "HafeLayer.h"

@implementation HafeLayer


+ (BOOL)needsDisplayForKey:(NSString *)key {
    
    if ([key isEqualToString:@"timeDuration"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    super.lineDashPattern = @[@2,@(self.timeDuration)];
    
}

@end
