//
//  ELKAccount.m
//  StarDreamiOS
//
//  Created by wing on 2019/8/13.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKAccount.h"
#import <MJExtension/MJExtension.h>

@implementation ELKAccount


MJExtensionCodingImplementation;


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
         @"userId" : @"id",
    };
}


@end
