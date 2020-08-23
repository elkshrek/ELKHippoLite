//
//  UIView+ELKAdditions.m
//  ELKCommonDemo
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import "UIView+ELKAdditions.h"

@implementation UIView (ELKAdditions)


#pragma mark - 添加阴影边框
- (void)elk_addShadowColor:(UIColor *)shadowColor offSet:(CGSize)offset opacity:(CGFloat)opacity
{
    [self elk_addShadowColor:shadowColor offSet:offset opacity:opacity shadowRadius:3.f];
}
- (void)elk_addShadowColor:(UIColor *)shadowColor offSet:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)radius
{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}



/// 绘制虚线
/// @param lineLength  虚线的宽度
/// @param lineSpacing 虚线的间距
/// @param lineColor   虚线的颜色
- (void)elk_drawVerticalDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(self.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}


/// 设置圆角
/// @param styleType type
/// @param cornerRadii 圆角
-(void)elk_maskCornerWithStyleType:(ELKRectCornerType)styleType cornerRadii:(CGFloat)cornerRadii {
    
    UIBezierPath *maskPath =[UIBezierPath bezierPath];
    
    switch (styleType) {
        case ELKRectCornerTopLeftRight:
            maskPath= [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
            break;
        case ELKRectCornerBottomLeftRight:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
            break;
        case ELKRectCornerTopLeft:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
            break;
        case ELKRectCornerTopRight:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
            break;
        case ELKRectCornerBottomLeft:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
            break;
        case ELKRectCornerBottomRight:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
            break;
        default:
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
            break;
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}


@end
