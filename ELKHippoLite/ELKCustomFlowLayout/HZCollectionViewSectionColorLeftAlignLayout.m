//
//  HZCollectionViewColorLeftAlignLayout.m
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/23.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZCollectionViewSectionColorLeftAlignLayout.h"


@interface HZCollectionViewSectionColorLeftAlignLayout()

@property (nonatomic, strong) UIColor *sectionColor;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationLayoutAttributes;

@end

@implementation HZCollectionViewSectionColorLeftAlignLayout

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    id<HZCollectionViewSectionColorDelegate> delegate = (id<HZCollectionViewSectionColorDelegate>)self.collectionView.delegate;
    if (![delegate respondsToSelector:@selector(collectionView:layout:attribute:backgroundColorAtSection:)]) {
        return;
    }
    [self registerClass:[HZColorCollectionReusableView class] forDecorationViewOfKind:@"DecorationView"];
    [self.decorationLayoutAttributes removeAllObjects];
    for (NSInteger i = 0; i < sectionCount; i++) {
        NSInteger itemNum = [self.collectionView numberOfItemsInSection:i];
        if (itemNum > 0) {
            UICollectionViewLayoutAttributes *firstItemLayoutAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            UICollectionViewLayoutAttributes *lastItemLayoutAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:itemNum - 1 inSection:i]];
            UIEdgeInsets sectionInset = [self evaluatSectionInsetsAtSection:i];
            CGRect sectionFrame = CGRectUnion(firstItemLayoutAttribute.frame, lastItemLayoutAttributes.frame);
            sectionFrame.origin.x = sectionFrame.origin.x - sectionInset.left;
            sectionFrame.origin.y = sectionFrame.origin.y - sectionInset.top;
//            CGSize headerSize = [self evaluatSectionHeaderSizeAtSection:i];
            
            if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                sectionFrame.size.width = sectionFrame.size.width + sectionInset.left + sectionInset.right;
                sectionFrame.size.height = self.collectionView.frame.size.height;
            } else {
//                sectionFrame.origin.y = sectionFrame.origin.y - headerSize.height;
                sectionFrame.size.width = self.collectionView.frame.size.width;
                sectionFrame.size.height = sectionFrame.size.height + sectionInset.top + sectionInset.bottom;
            }
            HZColorCollectionViewLayoutAttributes *layoutAttributes = [HZColorCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"DecorationView" withIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            HZColorCollectionViewLayoutAttributes *setColorLayoutAttributes = [delegate collectionView:self.collectionView layout:self attribute:layoutAttributes backgroundColorAtSection:i];
            setColorLayoutAttributes.frame = sectionFrame;
            setColorLayoutAttributes.zIndex = -1;
            [self.decorationLayoutAttributes addObject:setColorLayoutAttributes];
        } else {
//            continue;
            CGRect sectionFrame = CGRectZero;
            HZColorCollectionViewLayoutAttributes *layoutAttributes = [HZColorCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"DecorationView" withIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            HZColorCollectionViewLayoutAttributes *setColorLayoutAttributes = [delegate collectionView:self.collectionView layout:self attribute:layoutAttributes backgroundColorAtSection:i];
            setColorLayoutAttributes.frame = sectionFrame;
            [self.decorationLayoutAttributes addObject:setColorLayoutAttributes];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *returnAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in [super layoutAttributesForElementsInRect:rect]) {
        [returnAttributes addObject:attributes];
    }
    for (UICollectionViewLayoutAttributes *attributes in self.decorationLayoutAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [returnAttributes addObject:attributes];
        }
    }
    return returnAttributes;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationLayoutAttributes {
    if (!_decorationLayoutAttributes) {
        _decorationLayoutAttributes = [NSMutableArray array];
    }
    return _decorationLayoutAttributes;
}

- (UIEdgeInsets)evaluatSectionInsetsAtSection:(NSInteger)section {
    id<HZCollectionViewSectionColorDelegate> delegate = (id<HZCollectionViewSectionColorDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return self.sectionInset;
}

- (CGSize)evaluatSectionHeaderSizeAtSection:(NSInteger)section {
    id<HZCollectionViewSectionColorDelegate> delegate = (id<HZCollectionViewSectionColorDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}

@end
