//
//  ELKMantleSwizzling.h
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/1.
//  Copyright © 2019 elk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKMantleSwizzling : NSObject


/// 交换方法的实现
+ (void)elk_exchangeMethodWithClass:(id)objClass oriMethod:(SEL)oriSel newMethod:(SEL)newSel;


@end

NS_ASSUME_NONNULL_END
