//
//  ViewController.m
//  ELKCommonDemo
//
//  Created by wing on 2020/5/6.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ViewController.h"
#import "ELKHippoLite.h"
#import "ELKEasyTimerVC.h"
#import "ELKTableDataSourceVC.h"
#import "ELKTextDemoViewController.h"
#import "ELKNetworkManager.h"
#import "ELKBaseDataSource.h"
@interface ViewController ()<UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ELKBaseDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"ELEasyTimer", @"ELKTextField", @"触发登录失效回调", @"ELKDataSource"];
    [self.view addSubview: self.tableView];
    
    [ELKNetworkManager elk_catchLostLogin:^{
        NSLog(@"登录失效啦！！！！！！");
    }];
 }



-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        e_weakify(self);
        self.dataSource = [[ELKBaseDataSource alloc] initWithTableView:_tableView CellModel:^ELKBaseTableViewCellModel * _Nonnull(NSIndexPath * _Nonnull indexPath) {
            ELKBaseTableViewCellModel *model = [[ELKBaseTableViewCellModel alloc] initWithCellClass:UITableViewCell.class];
            model.dataModel = self.dataArray[indexPath.row];
            return model;
        } rowNumberOfSection:^NSUInteger(NSUInteger section) {
            e_strongify(self);
            return self.dataArray.count;
        } cellConfigure:^(UITableViewCell*  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
            
            cell.textLabel.text = model;
        }];
                           
        
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    switch (indexPath.row) {
        case 0:{
            ELKEasyTimerVC *vc = [[ELKEasyTimerVC alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:{
            ELKTextDemoViewController*vc = [[ELKTextDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 2:{

            [ELKNetworkManager elk_touchLostLogin];
        }
            
            break;
        case 3:{
            ELKTableDataSourceVC*vc = [[ELKTableDataSourceVC alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
    
    
}

@end
