//
//  ELKMantleSwizzling.m
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/1.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKMantleSwizzling.h"
#import <objc/runtime.h>


@implementation ELKMantleSwizzling


/// 交换方法的实现
+ (void)elk_exchangeMethodWithClass:(id)objClass oriMethod:(SEL)oriSel newMethod:(SEL)newSel
{
    Method fromMethod = class_getInstanceMethod([objClass class], oriSel);
    Method toMethod = class_getInstanceMethod([objClass class], newSel);
    
    if (!class_addMethod([objClass class], oriSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}




@end
