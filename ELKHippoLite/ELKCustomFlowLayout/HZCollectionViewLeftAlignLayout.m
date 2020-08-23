//
//  UICollectionViewLeftAlignmentLayout.m
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/23.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZCollectionViewLeftAlignLayout.h"

@interface UICollectionViewLayoutAttributes(leftAlignment)

- (void)leftAlignmentFrameWithSectionInset:(UIEdgeInsets)sectionInsets;

@end

@implementation UICollectionViewLayoutAttributes(leftAlignment)

- (void)leftAlignmentFrameWithSectionInset:(UIEdgeInsets)sectionInsets {
    CGRect frame = self.frame;
    frame.origin.x = sectionInsets.left;
    self.frame = frame;
}

@end

@implementation HZCollectionViewLeftAlignLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *returnAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in [super layoutAttributesForElementsInRect:rect]) {
        UICollectionViewLayoutAttributes *attributeCopy = [attribute copy];
        if (nil == attributeCopy.representedElementKind) {
            NSIndexPath *indexPath = attributeCopy.indexPath;
            attributeCopy.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
        [returnAttributes addObject:attributeCopy];
    }
    return [returnAttributes copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentAttribute = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    UIEdgeInsets sectionInset = [self evaluateSectionInsetsForItemAtIndex:indexPath.section];
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    if (indexPath.row == 0) {
        [currentAttribute leftAlignmentFrameWithSectionInset:sectionInset];
        return currentAttribute;
    }
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]].frame;
    CGRect currentFrame = currentAttribute.frame;
    CGRect sketchFrame = CGRectMake(self.sectionInset.left, currentFrame.origin.y, layoutWidth, currentFrame.size.height);
    BOOL isSameRow = CGRectIntersectsRect(sketchFrame, previousFrame);
    if (!isSameRow) {
        [currentAttribute leftAlignmentFrameWithSectionInset:sectionInset];
        return currentAttribute;
    }
    
    CGFloat previousRightPoint = previousFrame.origin.x + previousFrame.size.width;
    currentFrame.origin.x = previousRightPoint + [self evaluatMinimumInteritemSpaceingForSectionAtIndex:indexPath.section];
    currentAttribute.frame = currentFrame;
    return currentAttribute;
}

- (UIEdgeInsets)evaluateSectionInsetsForItemAtIndex:(NSInteger)section {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<HZCollectionViewLeftAlignLayoutDelegate> delegate = (id<HZCollectionViewLeftAlignLayoutDelegate>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return self.sectionInset;
}

- (CGFloat)evaluatMinimumInteritemSpaceingForSectionAtIndex:(NSInteger)section {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<HZCollectionViewLeftAlignLayoutDelegate> delegate = (id<HZCollectionViewLeftAlignLayoutDelegate>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    return self.minimumInteritemSpacing;
}

@end
