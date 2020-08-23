//
//  HZColorCollectionReusableView.h
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/23.
//  Copyright © 2019 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZColorCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat sectionAlpha;

@end

@interface HZColorCollectionReusableView : UICollectionReusableView


@end

NS_ASSUME_NONNULL_END
