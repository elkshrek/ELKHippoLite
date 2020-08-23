//
//  ELKContactManager.h
//  ELKHippoLite
//
//  Created by wing on 2020/1/3.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKContactInfoModel : NSObject

/// 头像
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *image;

/// 姓名
@property (nonatomic, copy) NSString *givenName;
/// 家庭姓氏
@property (nonatomic, copy) NSString *familyName;
/// 完整名字
@property (nonatomic, copy) NSString *fullName;
/// 名字的拼音
@property (nonatomic, copy) NSString *fullSpell;
/// 名字的首字母
@property (nonatomic, copy) NSString *indexPinYin;
/// 名字的最后一个字
@property (nonatomic, copy) NSString *lastLetter;

/// 手机号
@property (nonatomic, copy) NSString *mobile;
/// 手机号列表
@property (nonatomic, strong) NSArray <NSString *>*phoneNumbers;

@end

@interface ELKContactManager : NSObject


/// 检查通讯录权限 YES or NO
+ (BOOL)elk_checkContactAuthStatus;


/// 获取通讯录信息
/// @param complete 获取的通讯录信息
+ (void)elk_readContactList:(void(^)(NSArray <ELKContactInfoModel *>* contList))complete;


/// 取出排好序的索引数组
/// @param contList 通讯录信息
+ (NSArray<NSString *>*)elk_filterIndexFromArray:(NSArray<ELKContactInfoModel *> *)contList;


/// 排序·根据名字首字母排序
/// @param contList 通讯录信息
+ (NSArray<ELKContactInfoModel *> *)elk_sortObjectArray:(NSArray<ELKContactInfoModel *> *)contList;


/// 排序·并按首字母顺序分组
/// @param contList 通讯录信息
+ (NSArray *)elk_sortArrayAndOrderByPrefix:(NSArray<ELKContactInfoModel *> *)contList;


/// 搜索联系人
/// @param searchKey 搜索关键字
/// @param contList  通讯录信息
+ (NSArray *)elk_searchContactWithKey:(NSString *)searchKey sources:(NSArray<ELKContactInfoModel *> *)contList;



@end

NS_ASSUME_NONNULL_END
