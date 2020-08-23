//
//  ViewController.h
//  ELKCommonDemo
//
//  Created by wing on 2020/5/6.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface ELKPageItemModel : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *viewClass;

+ (instancetype)pageItemModel:(NSString *)title viewClass:(NSString *)viewClass;

@end
