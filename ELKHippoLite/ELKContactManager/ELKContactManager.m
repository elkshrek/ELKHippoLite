//
//  ELKContactManager.m
//  ELKHippoLite
//
//  Created by wing on 2020/1/3.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKContactManager.h"
#import <Contacts/Contacts.h>

// 特殊字符统一合并后的显示字符
#define ELKAbnormalLetter @"#"

@implementation ELKContactManager


/// 检查通讯录权限 YES or NO
+ (BOOL)elk_checkContactAuthStatus
{
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authStatus == CNAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}


/// 获取通讯录信息
/// @param complete 获取的通讯录信息
+ (void)elk_readContactList:(void (^)(NSArray<ELKContactInfoModel *> * _Nonnull))complete
{
    dispatch_async(dispatch_queue_create("com.addressBook.queue", DISPATCH_QUEUE_SERIAL), ^{
        NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactImageDataKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            NSArray *phoneNumbers = contact.phoneNumbers;
            CNLabeledValue *firstValue = phoneNumbers.firstObject;
            CNPhoneNumber *phoneNumber = firstValue.value;
            NSString *mobString = [self elk_gentleMobile:phoneNumber.stringValue];
            NSMutableArray *mutArray = [[NSMutableArray alloc] init];
            for (CNLabeledValue *labelValue in phoneNumbers) {
                CNPhoneNumber *pNumber = labelValue.value;
                NSString *mobNumber = [self elk_gentleMobile:pNumber.stringValue];
                [mutArray addObject:mobNumber];
                if (![ELKContactManager elk_isValidMobile:mobString]) {
                    mobString = mobNumber;
                }
            }
            
            if ([ELKContactManager elk_isValidMobile:mobString]) {
                ELKContactInfoModel *infoModel = [[ELKContactInfoModel alloc] init];
                infoModel.mobile = mobString;
                infoModel.phoneNumbers = [mutArray mutableCopy];
                infoModel.givenName = contact.givenName;
                infoModel.familyName = contact.familyName;
                infoModel.fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
                if ([contact isKeyAvailable:CNContactImageDataKey]) {
                    infoModel.image = [UIImage imageWithData:contact.imageData];
                }
                if ([contact isKeyAvailable:CNContactThumbnailImageDataKey]) {
                    infoModel.thumbnailImage = [UIImage imageWithData:contact.thumbnailImageData];
                }
                NSString *nameSpell = [ELKContactManager elk_transformAlphabet:infoModel.fullName];
                infoModel.fullSpell = [nameSpell stringByReplacingOccurrencesOfString:@" " withString:@""];
                infoModel.indexPinYin = [ELKContactManager elk_exchangeFirstLetter:infoModel.fullName];
                [tempArray addObject:infoModel];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(tempArray);
            }
        });
    });
}


/// 取出排好序的索引数组
/// @param contList 通讯录信息
+ (NSArray<NSString *>*)elk_filterIndexFromArray:(NSArray<ELKContactInfoModel *> *)contList
{
    NSArray *tempArray = [self elk_sortObjectArray:contList];
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    NSString *tempPinYin;
    for (ELKContactInfoModel *infoModel in tempArray) {
        NSString *itemPrefix = infoModel.indexPinYin.length ? [infoModel.indexPinYin substringToIndex:1] : @"";
        if (![itemPrefix isEqualToString:tempPinYin]) {
            tempPinYin = itemPrefix;
            [resArray addObject:itemPrefix];
        }
    }
    return resArray;
}


/// 排序·根据名字首字母排序
/// @param contList 通讯录信息
+ (NSArray<ELKContactInfoModel *> *)elk_sortObjectArray:(NSArray<ELKContactInfoModel *> *)contList
{
    if (!contList || !contList.count) {
        return @[];
    }
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithArray:contList];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"indexPinYin" ascending:YES]];
    [mutArray sortUsingDescriptors:sortDescriptors];
    
    return mutArray;
}


/// 排序·并安首字母顺序分组
/// @param contList 通讯录信息
+ (NSArray *)elk_sortArrayAndOrderByPrefix:(NSArray<ELKContactInfoModel *> *)contList
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[self elk_sortObjectArray:contList]];
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    NSMutableArray *item = [[NSMutableArray alloc] init];
    NSString *tempString;
    // 分组
    for (ELKContactInfoModel *contModel in tempArray) {
        NSString *pinyin = contModel.indexPinYin.length ? [contModel.indexPinYin substringToIndex:1] : @"";
        if ([tempString isEqualToString:pinyin]) {
            [item addObject:contModel];
        } else {
            item = [[NSMutableArray alloc] init];
            [item addObject:contModel];
            [resArray addObject:item];
            tempString = pinyin;
        }
    }
    
    return resArray;
}

#pragma mark - Contact search with key
/// 搜索联系人
/// @param searchKey 搜索关键字
/// @param contList  通讯录信息
+ (NSArray *)elk_searchContactWithKey:(NSString *)searchKey sources:(NSArray<ELKContactInfoModel *> *)contList
{
    NSString *contactKey = searchKey ?: @"";
    if (!contactKey.length) {
        return @[];
    }
    if ([self elk_checkNumText:contactKey]) {
        return [self elk_searchWithMobile:contactKey sources:contList];
    } else if ([self elk_checkAlphabetText:contactKey]) {
        return [self elk_searchWithAlphabetName:contactKey sources:contList];
    } else {
        return [self elk_searchWithName:contactKey sources:contList];
    }
}

/// 通过姓名搜索联系人
+ (NSArray *)elk_searchWithName:(NSString *)name sources:(NSArray *)contArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.fullName CONTAINS[cd] %@", name];
    NSArray *resArray = [[contArray filteredArrayUsingPredicate:predicate] copy];
    return resArray;
}
/// 通过姓名拼音搜索联系人
+ (NSArray *)elk_searchWithAlphabetName:(NSString *)name sources:(NSArray *)contArray
{
    NSString *nameSpell = [name uppercaseString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.fullSpell CONTAINS[cd] %@", nameSpell];
    NSArray *resArray = [[contArray filteredArrayUsingPredicate:predicate] copy];
    return resArray;
}
/// 通过手机号搜索联系人
+ (NSArray *)elk_searchWithMobile:(NSString *)mobile sources:(NSArray *)contArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.mobile CONTAINS[cd] %@", mobile];
    NSArray *resArray = [[contArray filteredArrayUsingPredicate:predicate] copy];
    return resArray;
}

/// 校验输入是否为纯数字
+ (BOOL)elk_checkNumText:(NSString *)text
{
    NSString *pattern = @"^[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL match = [pred evaluateWithObject:text];
    return match;
}
/// 校验输入是否为纯字母
+ (BOOL)elk_checkAlphabetText:(NSString *)text
{
    NSString *pattern = @"^[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL match = [pred evaluateWithObject:text];
    return match;
}

+ (NSString *)elk_gentleMobile:(NSString *)mobile
{
    NSString *gentleMobile = mobile ?: @"";
    if ([gentleMobile hasPrefix:@"+86"]) {
        gentleMobile = [gentleMobile stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    gentleMobile = [gentleMobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
    gentleMobile = [gentleMobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    gentleMobile = [gentleMobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableString *result = [[NSMutableString alloc] init];
    [gentleMobile enumerateSubstringsInRange:NSMakeRange(0, gentleMobile.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([self elk_checkNumberCharacter:substring]) {
            [result appendString:substring];
        }
    }];
    
    return result;
}

+ (BOOL)elk_checkNumberCharacter:(NSString *)character
{
    NSString *number = @"^[0-9]{1}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
    return [predicate evaluateWithObject:character];
}

/// 名字转换为拼音
+ (NSString *)elk_transformAlphabet:(NSString *)text
{
    NSString *chinese = text ?: @"";
    if (chinese.length == 0) {
        return @"#";
    }
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    if ([pinyin isEqualToString:@""]) {
        return ELKAbnormalLetter;
    }
    return [pinyin uppercaseString];
}

/// 转换首字符为字母
/// @param nameString name
+ (NSString *)elk_exchangeFirstLetter:(NSString *)nameString
{
    NSString *tempString = nameString ?: @"";
    tempString = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    tempString = [self elk_removeSpecialCharacter:tempString];
    
    // 判断首字符是否为字母
    NSString *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *prefixStr = tempString.length ? [tempString substringToIndex:1] : @"";
    NSString *pinYin = @"";
    if ([predicate evaluateWithObject:prefixStr]) {
        pinYin = [tempString capitalizedString];
    } else {
        if (tempString.length) {
            pinYin = [self elk_getFirstLetter:tempString];
        } else {
            pinYin = ELKAbnormalLetter;
        }
    }
    return pinYin;
}

/// 获得词语中每个字的首字母
/// @param chinese 文案
+ (NSString *)elk_getFirstLetter:(NSString *)chinese
{
    NSString *pinyin = [self elk_transformAlphabet:chinese];
    if ([pinyin isEqualToString:ELKAbnormalLetter]) {
        return pinyin;
    }
    // 把拼音按字分开
    NSArray *letterArray = [pinyin componentsSeparatedByString:@" "];
    if (!letterArray || letterArray.count == 0) {
        return ELKAbnormalLetter;
    }
    NSMutableString *result = @"".mutableCopy;
    for (NSString *letter in letterArray) {
        [result appendString:[letter substringToIndex:1]];
    }
    result = [result uppercaseString].mutableCopy;
    // 判断第一个字符是否为字母
    if ([self elk_isCatipalLetter:result]) {
        return result;
    } else {
        return ELKAbnormalLetter;
    }
    return [result uppercaseString];
}

/// 过滤特殊字符串
/// @param str 需要过滤的文案
+ (NSString*)elk_removeSpecialCharacter:(NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString: @",.？、~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound) {
        return [self elk_removeSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}

/// 判断第一个字符是否是大写字母
/// @param str 内容
+ (BOOL)elk_isCatipalLetter:(NSString *)str
{
    if ([str characterAtIndex:0] >= 'A' && [str characterAtIndex:0] <= 'Z') {
        return YES;
    }
    return NO;
}

/// 判断是否是大陆手机号
/// @param mobile 手机号码
+ (BOOL)elk_isValidMobile:(NSString *)mobile
{
    NSString *mobileStr = mobile ?: @"";
    NSString *pattern = @"^1(3|4|5|6|7|8|9)\\d{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:mobileStr];
}


@end

@implementation ELKContactInfoModel

- (void)setFullName:(NSString *)fullName
{
    _fullName = fullName;
    self.lastLetter = fullName.length ? [fullName substringFromIndex:fullName.length - 1] : @"";
}

@end
