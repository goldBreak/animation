//
//  UIView+UIView.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/22.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "UIView+UIView.h"

@implementation UIView (UIView)

- (CGFloat)originX {
    
    return CGRectGetMinX(self.frame);
}

- (CGFloat)originY {
    
    return CGRectGetMinY(self.frame);
}

- (CGFloat)width {
    
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    
    return CGRectGetHeight(self.frame);
}

- (CGFloat)maxX {
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)midX {
    
    return (self.originX + self.width) / 2.0;
}

- (CGFloat)midY {
    
    return (self.originY + self.height) / 2.0;
}

@end
