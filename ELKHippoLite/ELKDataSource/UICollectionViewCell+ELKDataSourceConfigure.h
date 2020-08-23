//
//  UICollectionViewCell+ELKDataSourceConfigure.h
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELKBaseTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (ELKDataSourceConfigure)

/// 根据model更新UI  交给子类实现
/// @param cellModel cellModel
- (void)configureUIWithCellModel:(ELKBaseTableViewCellModel *)cellModel;

@end

NS_ASSUME_NONNULL_END
