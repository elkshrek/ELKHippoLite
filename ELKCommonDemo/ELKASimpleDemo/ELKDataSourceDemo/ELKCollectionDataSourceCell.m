//
//  ELKCollectionDataSourceCell.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKCollectionDataSourceCell.h"
#import <Masonry/Masonry.h>
@implementation ELKCollectionDataSourceCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configureUIWithCellModel:(ELKBaseTableViewCellModel *)cellModel{
    NSDictionary *dataModel = cellModel.dataModel;
    self.textLabel.text = [NSString stringWithFormat:@"%@-%@", dataModel[@"name"], dataModel[@"age"]];
 
}

@end
