//
//  HZColorCollectionReusableView.m
//  UICollectionViewSelectedTest
//
//  Created by newmac on 2019/5/23.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "HZColorCollectionReusableView.h"

@implementation HZColorCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    HZColorCollectionViewLayoutAttributes *colorLayoutaAttributes = (HZColorCollectionViewLayoutAttributes *)layoutAttributes;
    self.backgroundColor = colorLayoutaAttributes.backgroundColor;
    self.alpha = colorLayoutaAttributes.sectionAlpha;
}

@end

@implementation HZColorCollectionViewLayoutAttributes


@end
