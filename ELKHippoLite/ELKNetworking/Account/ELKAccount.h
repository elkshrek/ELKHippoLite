//
//  ELKAccount.h
//  StarDreamiOS
//
//  Created by wing on 2019/8/13.
//  Copyright © 2019 elk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 项目中需要添加特有用户信息时，请继承此类，来声明属性，然后遵守<NSCoding>并实现协议方法！！！
@interface ELKAccount : NSObject<NSCoding>

/// 用户id
@property (nonatomic , assign) NSNumber *userId;
/// 用户类型
@property (nonatomic, strong) NSNumber *type;
/// 用户类型
@property (nonatomic, strong) NSNumber *userType;
/// 更新时间
@property (nonatomic, strong) NSNumber *updateTime;
/// 创建时间
@property (nonatomic, strong) NSNumber *createTime;
/// 设备号
@property (nonatomic, strong) NSNumber *machineCode;
/// 是否完善了信息
@property (nonatomic, strong) NSNumber *perfectInfo;
/// 是否需要加密
@property (nonatomic , strong) NSNumber *enableAuth;
/// 手机号
@property (nonatomic, copy) NSString *mobile;
/// 昵称
@property (nonatomic, copy) NSString *nickName;
/// 真实姓名
@property (nonatomic, copy) NSString *realName;
/// 头像url
@property (nonatomic, copy) NSString *headerImg;
/// token
@property (nonatomic, copy) NSString *token;




@end

NS_ASSUME_NONNULL_END
