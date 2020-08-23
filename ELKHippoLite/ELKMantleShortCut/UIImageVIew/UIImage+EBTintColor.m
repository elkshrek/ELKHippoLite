//
//  UIImage+VPTintColor.m
//  VIP800
//
//  Created by EXphinx's Macbook Pro on 12/17/13.
//  Copyright (c) 2013 EB.CN. All rights reserved.
//

#import "UIImage+EBTintColor.h"

@implementation UIImage (EBTintColor)

- (UIImage *)elk_imageWithTintColor:(UIColor *)color
{
    if (!color) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, YES, [[UIScreen mainScreen] scale]);
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [self size];
    
    // Retrieve source image and begin image context
    CGSize itemImageSize = [self size];
    CGPoint itemImagePosition;
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
    
    UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Setup shadow
    // Setup transparency layer and clip to mask
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [self CGImage]);
    // Fill and end the transparency layer
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(color.CGColor);
    CGColorSpaceModel model = CGColorSpaceGetModel(colorSpace);
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    
    if(model == kCGColorSpaceModelMonochrome)
    {
        CGContextSetRGBFillColor(c, colors[0], colors[0], colors[0], colors[1]);
    }else{
        CGContextSetRGBFillColor(c, colors[0], colors[1], colors[2], colors[3]);
    }
    contextRect.size.height = -contextRect.size.height;
    contextRect.size.height -= 15;
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// http://stackoverflow.com/questions/5084845/how-to-set-the-opacity-alpha-of-a-uiimage
- (UIImage *)imageWithAlphaComponent:(CGFloat)alpha {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)emptyImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    if (color) {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(c, color.CGColor);
        CGContextFillRect(c, CGRectMake(0, 0, size.width, size.height));
    }
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)segmentedControlBackgroundImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    return [self barButtonBackgroundImageWithBorderColor:color cornerRadius:cornerRadius];
}

+ (UIImage *)segmentedControlSelectedBackgroundImageWithColor:(UIColor *)color
                                                 cornerRadius:(CGFloat)cornerRadius {
    
    CGSize size = CGSizeMake(100, 20);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    //// Color Declarations
    UIColor* fillColor = color;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, size.width-1, size.height-1) cornerRadius: cornerRadius];
    [fillColor setFill];
    [roundedRectanglePath fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGFloat edge = cornerRadius + 2;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(edge, edge, edge, edge)];
}

+ (UIImage *)segmentedControlDividerImageWithColor:(UIColor *)color {
    
    CGSize size = CGSizeMake(1, 20);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    //// Color Declarations
    UIColor* fillColor = color;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0.5, 1, size.height - 1)];
    [fillColor setFill];
    [roundedRectanglePath fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGFloat edge = 1;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(edge, 0, edge, 0)];

}

+ (UIImage *)barButtonBackgroundImageWithBorderColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    return [self barButtonBackgroundImageWithBorderColor:color fillColor:[UIColor clearColor] cornerRadius:cornerRadius];
}

+ (UIImage *)barButtonBackgroundImageWithBorderColor:(UIColor *)color fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius {
    
    CGSize size = CGSizeMake(100, 20);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    //// Color Declarations
    UIColor* strokeColor = color;
    
    //// Rounded Rectangle Drawing
    CGFloat borderWidth = 1.f / [[UIScreen mainScreen] scale];
//    CGFloat borderWidth = 1;
    
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(borderWidth, borderWidth, size.width - borderWidth * 2, size.height - borderWidth * 2) cornerRadius: cornerRadius];
    [fillColor setFill];
    [roundedRectanglePath fill];
    [strokeColor setStroke];
    roundedRectanglePath.lineWidth = borderWidth;
    [roundedRectanglePath stroke];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGFloat edge = cornerRadius + 2;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(edge, edge, edge, edge)
                               resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)roundedRectBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth edgeInsets:(UIEdgeInsets)edgeInsets color:(UIColor *)borderColor {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    //// Color Declarations
    UIColor* strokeColor = borderColor;
    
    //// Rounded Rectangle Drawing
    
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(edgeInsets.left + borderWidth,edgeInsets.top + borderWidth, size.width - borderWidth * 2 - edgeInsets.left - edgeInsets.right, size.height - borderWidth * 2 - edgeInsets.top - edgeInsets.bottom) cornerRadius: cornerRadius];
    
    [fillColor setFill];
    [roundedRectanglePath fill];
    [strokeColor setStroke];
    roundedRectanglePath.lineWidth = borderWidth;
    [roundedRectanglePath stroke];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGFloat inset = borderWidth + cornerRadius + 1;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(inset, inset, inset, inset) resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)roundedRectBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor {
    return [self roundedRectBorderImageWithSize:size cornerRadius:cornerRadius fillColor:fillColor borderWidth:borderWidth edgeInsets:UIEdgeInsetsZero color:borderColor];
}


+ (UIImage *)backButtonImageWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor {
    return [self backButtonImageWithSize:CGSizeMake(100, 30) cornerRadius:cornerRadius fillColor:fillColor borderWidth:borderWidth color:borderColor];
}

+ (UIImage *)backButtonImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor {

    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    //// Color Declarations
    UIColor* strokeColor = borderColor;
    
    //// Rounded Rectangle Drawing
    
    UIBezierPath* path  = [self bezierPathForBackButtonInRect:CGRectMake(borderWidth, borderWidth, size.width - borderWidth * 2, size.height - borderWidth * 2) withRoundingRadius:cornerRadius andArrowWidth:0];
    if (fillColor) {
        [fillColor setFill];
        [path fill];
    }
    
    [strokeColor setStroke];
    path.lineWidth = borderWidth;
    [path stroke];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(size.height / 2, 7, size.height / 2, cornerRadius + 2)];
}

+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect withRoundingRadius:(CGFloat)radius andArrowWidth:(CGFloat)arrowWidth {
    if (!arrowWidth) {
        arrowWidth = 6;
    }
    CGFloat angle = atan2f(CGRectGetMidY(rect) - rect.origin.y, arrowWidth);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI + M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + arrowWidth + (radius);
    [path addLineToPoint:mPoint];
    
    ctrlPoint = CGPointMake(mPoint.x, CGRectGetMaxY(rect) - radius);
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI_2 endAngle:M_PI_2+angle clockwise:YES];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    ctrlPoint = CGPointMake(rect.origin.x + arrowWidth + radius, rect.origin.y + radius);
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI + angle endAngle:M_PI+M_PI_2 clockwise:YES];
    
    [path closePath];
    return path;
}
@end
