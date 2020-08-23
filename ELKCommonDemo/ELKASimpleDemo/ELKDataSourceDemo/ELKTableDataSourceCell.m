//
//  ELKTableDataSourceCell.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKTableDataSourceCell.h"
#import "ELKBaseDataSource.h"

@implementation ELKTableDataSourceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureUIWithCellModel:(ELKBaseTableViewCellModel *)cellModel{
    NSDictionary *dataModel = cellModel.dataModel;
    self.textLabel.text = [NSString stringWithFormat:@"%@-%@", dataModel[@"name"], dataModel[@"age"]];
 
}

@end
