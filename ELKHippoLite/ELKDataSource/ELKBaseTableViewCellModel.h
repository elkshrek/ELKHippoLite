//
//  ELKBaseTableViewCellModel.h
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKBaseTableViewCellModel : NSObject

/// 记录cell高度
@property (nonatomic, assign) CGFloat cellHeight;
/// cellIdentifier 默认取类名
@property (nonatomic, strong) NSString *cellIdentifier;
/// cell类
@property (nonatomic, strong) Class cellClass;
/// cell从nib加载时需要
@property (nonatomic, strong) UINib *nib;
/// 数据模型
@property (nonatomic, strong) id dataModel;



/// 初始化
/// @param cls cell类
- (instancetype)initWithCellClass:(Class)cls;

/// 初始化  - 自定义identifier
/// @param cls cell类
/// @param identifier 自定义identifier
- (instancetype)initWithCellClass:(Class)cls identifier:(NSString * _Nullable)identifier;

/// 初始化  - 自定义identifier  从nib加载
/// @param cls cell类
/// @param nib nib
/// @param identifier 自定义identifier
- (instancetype)initWithCellClass:(Class)cls fromNib:(UINib *_Nullable)nib identifier:(NSString * _Nullable)identifier ;

@end

NS_ASSUME_NONNULL_END
