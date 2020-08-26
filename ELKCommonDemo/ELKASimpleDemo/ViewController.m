//
//  ViewController.m
//  ELKCommonDemo
//
//  Created by wing on 2020/5/6.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ViewController.h"
#import "ELKHippoLite.h"
#import <Masonry/Masonry.h>

@class ELKPageItemModel;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组件示例列表";
    self.view.elk_setBackgroundColor(UIColor.whiteColor)
    .elk_addSubview(self.tableView);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ELKPageItemModel *itemModel = self.dataArray[indexPath.row];
    cell.textLabel.elk_setText(stdString(itemModel.title));
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELKPageItemModel *itemModel = self.dataArray[indexPath.row];
    Class viewClass = NSClassFromString(stdString(itemModel.viewClass));
    [self.navigationController pushViewController:[viewClass new] animated:YES];
}

- (UITableView *)tableView
{
    return _tableView ?: ({
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.elk_setDelegate(self)
        .elk_setDataSource(self)
        .elk_setSectionHeadHeight(0.02f)
        .elk_setSectionFootHeight(0.02f)
        .elk_setRowHeight(49.f);
        
        _tableView;
    });
}

- (NSArray *)dataArray
{
    return _dataArray ?: ({
        _dataArray = @[[ELKPageItemModel pageItemModel:@"easy timer" viewClass:@"ELKEasyTimeViewController"]];
        
        _dataArray;
    });
}

@end

@interface ELKPageItemModel()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *viewClass;

@end

@implementation ELKPageItemModel

+ (instancetype)pageItemModel:(NSString *)title viewClass:(NSString *)viewClass
{
    ELKPageItemModel *itemModel = [[ELKPageItemModel alloc] init];
    itemModel.title = title;
    itemModel.viewClass = viewClass;
    return itemModel;
}

@end
