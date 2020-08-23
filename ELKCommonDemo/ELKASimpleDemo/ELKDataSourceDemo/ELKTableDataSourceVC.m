//
//  ELKTableDataSourceVC.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKTableDataSourceVC.h"
#import "ELKBaseDataSource.h"
#import "ELKTableDataSourceCell.h"
#import "ELKHippoLite.h"
#import "ELKCollectionDataSourceVC.h"

@interface ELKTableDataSourceVC ()<ELKDataBaseLoadDelegate, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ELKBaseDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ELKTableDataSourceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


#pragma mark ELKDataBaseLoadDelegate
- (void)loadDataWithPage:(NSInteger)page overAction:(void (^_Nonnull)(BOOL success, BOOL isAllLoad))loadOver {

    
    if (page == 1) {
        [self.dataArray removeAllObjects];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 10; i++) {
            
            NSDictionary *dic =  @{@"name" : @"这个是我的名字 ", @"age":[NSString stringWithFormat:@"%d", i+1]};
            [self.dataArray addObject:dic];
        }
        if (page == 3) {
            loadOver(YES,YES);
        }else {
            loadOver(YES,NO);

        }
        [self.tableView reloadData];
    });
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ELKCollectionDataSourceVC *vc = [[ELKCollectionDataSourceVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}


#pragma mark getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        e_weakify(self);
    
        //初始化dataSource
        self.dataSource = [[ELKBaseDataSource alloc] initWithTableView:_tableView CellModel:^ELKBaseTableViewCellModel * _Nonnull(NSIndexPath * _Nonnull indexPath) {
            e_strongify(self);
            ELKBaseTableViewCellModel *model = [[ELKBaseTableViewCellModel alloc] initWithCellClass:ELKTableDataSourceCell.class];
            model.dataModel = self.dataArray[indexPath.row];
            return model;
        } rowNumberOfSection:^NSUInteger(NSUInteger section) {
            e_strongify(self);
            return self.dataArray.count;
        } cellConfigure:^(ELKTableDataSourceCell*  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
            //设置cell
            NSLog(@"cell :%@ model:%@",cell,model);
        }];
        
        //设置分页加载
        [self.dataSource setupPullDownToRefresh:YES pullUpToLoadMore:YES autoBegainRefreshing:YES  delegate:self];

    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
