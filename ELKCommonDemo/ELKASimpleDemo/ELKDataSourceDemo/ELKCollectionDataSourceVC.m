//
//  ELKCollectionDataSourceVC.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKCollectionDataSourceVC.h"
#import "ELKCollectionDataSourceCell.h"
#import "ELKBaseDataSource.h"
#import "ELKHippoLite.h"

@interface ELKCollectionDataSourceVC ()<ELKDataBaseLoadDelegate>
 @property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ELKBaseDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ELKCollectionDataSourceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.collectionView];
    
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
        [self.collectionView reloadData];
    });
    
}

#pragma mark getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(200, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:ELKCollectionDataSourceCell.class forCellWithReuseIdentifier:NSStringFromClass(ELKCollectionDataSourceCell.class)];
        e_weakify(self);
        //初始化dataSource
        self.dataSource = [[ELKBaseDataSource alloc] initWithCollectionView:_collectionView CellModel:^ELKBaseTableViewCellModel * _Nonnull(NSIndexPath * _Nonnull indexPath) {
            e_strongify(self);
            ELKBaseTableViewCellModel *model = [[ELKBaseTableViewCellModel alloc] initWithCellClass:ELKCollectionDataSourceCell.class];
            model.dataModel = self.dataArray[indexPath.row];
            return model;
        } rowNumberOfSection:^NSUInteger(NSUInteger section) {
            e_strongify(self);
            return self.dataArray.count;
        } cellConfigure:^(ELKCollectionDataSourceCell*  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
            //设置cell
            
        }];
        
        //设置分页加载
        [self.dataSource setupPullDownToRefresh:YES pullUpToLoadMore:YES autoBegainRefreshing:YES  delegate:self];

    }
    return _collectionView;
}

@end
