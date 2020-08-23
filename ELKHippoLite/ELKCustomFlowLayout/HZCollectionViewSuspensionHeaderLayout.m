//
//  HZCollectionViewSuspensionHeaderLayout.m
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/24.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZCollectionViewSuspensionHeaderLayout.h"

@implementation HZCollectionViewSuspensionHeaderLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *superAttributes = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    NSMutableIndexSet *noSectionIndexSet = [NSMutableIndexSet indexSet];
    //将屏幕显示的section的index添加进集合
    for (UICollectionViewLayoutAttributes *attributes in superAttributes) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [noSectionIndexSet addIndex:attributes.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *attributes in superAttributes) {
        if (attributes.representedElementKind == UICollectionElementKindSectionHeader) {
            [noSectionIndexSet removeIndex:attributes.indexPath.section];
        }
    }
    
    //将分区仍在显示但header已经离开屏幕的attributes重新添加回来
    [noSectionIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:idx];
        UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (headerAttributes) {
            [superAttributes addObject:headerAttributes];
        }
    }];
    for (UICollectionViewLayoutAttributes *attributes in superAttributes) {
        if (attributes.representedElementKind == UICollectionElementKindSectionHeader) {
            NSInteger itemNumber = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForRow:0 inSection:attributes.indexPath.section];
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForRow:MAX(0, itemNumber) inSection:attributes.indexPath.section];
            UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
            UIEdgeInsets sectionInset = [self evaluteSectionIndexAtIndex:attributes.indexPath.section];
            if (itemNumber > 0) {
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            } else {
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                CGFloat originY = attributes.frame.origin.y;
                firstItemAttributes.frame = CGRectMake(0, originY + sectionInset.top, 0, 0);
                lastItemAttributes = firstItemAttributes;
            }
            CGRect headerRect = attributes.frame;
            CGFloat offsetY = self.collectionView.contentOffset.y + self.navigationBarHeight;
            CGFloat headerY = firstItemAttributes.frame.origin.y - CGRectGetHeight(headerRect) - sectionInset.top;
            CGFloat maxY = MAX(offsetY, headerY);
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + self.sectionInset.bottom - CGRectGetHeight(headerRect);
            headerRect.origin.y = MIN(maxY, headerMissingY);
            attributes.frame = headerRect;
            attributes.zIndex = 2;
        }
    }
    return [superAttributes copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UIEdgeInsets)evaluteSectionIndexAtIndex:(NSInteger)index {
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        UIEdgeInsets sectionInset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
        return sectionInset;
    }
    return self.sectionInset;
}

@end
