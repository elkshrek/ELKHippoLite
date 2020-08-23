//
//  TFDialogueAllSubjectLayout.m
//  TFFund
//
//  Created by newmac on 2019/6/19.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZCustomeFlowLayout.h"

@implementation HZCustomeFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    return arr;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    CGFloat collectionWidth = self.collectionView.bounds.size.width;
//    CGRect visiableRect = CGRectMake(proposedContentOffset.x, 0, collectionWidth, self.collectionView.bounds.size.height);
//    NSArray *attributes = [super layoutAttributesForElementsInRect:visiableRect];
//    CGFloat minDelta = MAXFLOAT;
//    CGFloat centerX = self.collectionView.bounds.size.width / 2 + proposedContentOffset.x;
//    for (UICollectionViewLayoutAttributes *attribute in attributes) {
//        if (ABS(minDelta) > ABS(attribute.center.x - centerX)) {
//            minDelta = attribute.center.x - centerX;
//        }
//    }
//    proposedContentOffset.x = proposedContentOffset.x + minDelta;
//    return proposedContentOffset;
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
