//
//  ELKBaseTableViewCellModel.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKBaseTableViewCellModel.h"

@implementation ELKBaseTableViewCellModel

- (instancetype)initWithCellClass:(Class)cls {
    
    return [self initWithCellClass:cls identifier:NSStringFromClass(cls)];
}

- (instancetype)initWithCellClass:(Class)cls identifier:(NSString * _Nullable )identifier {

    return [self initWithCellClass:cls fromNib:nil identifier:NSStringFromClass(cls)];
}

- (instancetype)initWithCellClass:(Class)cls fromNib:(UINib * _Nullable )nib identifier:(NSString * _Nullable )identifier {
    self = [super init];
    if (self) {
        self.cellClass = cls;
        if (identifier) {
            self.cellIdentifier = identifier;
        }else {
            self.cellIdentifier = NSStringFromClass(cls);
        }
        self.nib = nib;
    }
    return self;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 44;
    }
    return _cellHeight;
}
@end
