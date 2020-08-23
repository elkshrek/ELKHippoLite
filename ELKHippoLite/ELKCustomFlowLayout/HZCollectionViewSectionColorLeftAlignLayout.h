//
//  HZCollectionViewColorLeftAlignLayout.h
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/23.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZCollectionViewLeftAlignLayout.h"
#import "HZColorCollectionReusableView.h"


NS_ASSUME_NONNULL_BEGIN

@protocol HZCollectionViewSectionColorDelegate <UICollectionViewDelegateFlowLayout>

- (HZColorCollectionViewLayoutAttributes *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout attribute:(UICollectionViewLayoutAttributes *)attributes backgroundColorAtSection:(NSInteger)section;

@end

@interface HZCollectionViewSectionColorLeftAlignLayout : HZCollectionViewLeftAlignLayout

@end

NS_ASSUME_NONNULL_END
