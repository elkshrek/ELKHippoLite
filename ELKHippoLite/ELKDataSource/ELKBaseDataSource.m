//
//  ELKBaseDataSource.m
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKBaseDataSource.h"
#import <MJRefresh/MJRefresh.h>
@interface ELKBaseDataSource()

//内容视图  UITableview 或 UICollectionView
@property (nonatomic, strong) UIScrollView *contentView;


@end


@implementation ELKBaseDataSource

/// 初始化tableView的Datasource
- (instancetype)initWithTableView:(UITableView *)tableView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection {
    
    return [self initWithTableView:tableView CellModel:cellModelOfIndexPath rowNumberOfSection:numberOfCellSection cellConfigure:nil];
}

/// 初始化tableView的Datasource - 加cellConfigure
- (instancetype)initWithTableView:(UITableView *)tableView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection  cellConfigure:(_Nullable CellConfigure)cellConfigure {

    self = [super init];
    if (self) {
        tableView.dataSource = self;
        self.contentView = tableView;
        self.cellModelOfIndexPath = cellModelOfIndexPath;
        self.numberOfCellSection = numberOfCellSection;
        self.cellConfigure = cellConfigure;
    }
    return self;
}

/// 初始化collectionView的Datasource - 加cellConfigure
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection  cellConfigure:(_Nullable CellConfigure)cellConfigure {
    
    self = [super init];
    if (self) {
        collectionView.dataSource = self;
        self.contentView = collectionView;
        self.cellModelOfIndexPath = cellModelOfIndexPath;
        self.numberOfCellSection = numberOfCellSection;
        self.cellConfigure = cellConfigure;
    }
    return self;
    
}



/// 设置下拉刷新 上拉加载
- (void)setupPullDownToRefresh:(BOOL)refresh pullUpToLoadMore:(BOOL)loadMore autoBegainRefreshing:(BOOL)begainRefreshing delegate:(id <ELKDataBaseLoadDelegate>)delegate {

    self.delegate = delegate;
    __weak typeof(self) weakSelf = self;
    
    if (refresh) {
        self.contentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong typeof(self) self = weakSelf;
            self.page = 1;
            self.isAllLoad = NO;
            if ([self.delegate respondsToSelector:@selector(loadDataWithPage:overAction:)]) {
                [self.delegate loadDataWithPage:self.page overAction:^(BOOL success, BOOL isAllLoad) {
                    self.isAllLoad = isAllLoad;
                    [self.contentView.mj_header endRefreshing];
                }];
            }
        }];

        //自动获取第一页
        if (begainRefreshing) {
            [self.contentView.mj_header beginRefreshing];
        }
    }
    if (loadMore) {
        self.contentView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(self) self = weakSelf;
            self.page ++ ;
            if ([self.delegate respondsToSelector:@selector(loadDataWithPage:overAction:)]) {
                [self.delegate loadDataWithPage:self.page overAction:^(BOOL success, BOOL isAllLoad) {
                    self.isAllLoad = isAllLoad;
                    if (!success) {
                        //请求失败恢复页码
                        self.page -- ;
                    }
                }];
            }
        }];
    }
    
}

/// 设置是否加载完成
- (void)setIsAllLoad:(BOOL)isAllLoad {
    _isAllLoad = isAllLoad;
    if (isAllLoad) {
        [self.contentView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.contentView.mj_footer resetNoMoreData];
    }
}

 
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.numberOfSection) {
        return self.numberOfSection();
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.numberOfCellSection) {
        return self.numberOfCellSection(section);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELKBaseTableViewCellModel *model;
    if (self.cellModelOfIndexPath) {
        model  = self.cellModelOfIndexPath(indexPath);
    }
    Class cellClass = model.cellClass;
    if (![[cellClass alloc] isKindOfClass:UITableViewCell.class]) {
        cellClass = UITableViewCell.class;
    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:model.cellIdentifier];
    if (!cell) {
        
        if (model.nib) {
            NSArray *nibArr =  [model.nib instantiateWithOwner:self options:nil];
            cell = [nibArr firstObject];
        }else {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.cellIdentifier];
        }
    }
    //根据model更新Cell
    [cell configureUIWithCellModel:model];
    
    //附加的cellConfigure
    if (self.cellConfigure) {
        self.cellConfigure(cell, model, indexPath);
    }
    
    return cell;
}


#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.numberOfCellSection) {
        return self.numberOfCellSection(section);
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELKBaseTableViewCellModel *model;
    if (self.cellModelOfIndexPath) {
        model  = self.cellModelOfIndexPath(indexPath);
    }
    Class cellClass = model.cellClass;
    if (![[cellClass alloc] isKindOfClass:UITableViewCell.class]) {
        cellClass = UITableViewCell.class;
    }
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.cellIdentifier forIndexPath:indexPath];
    
    //根据model更新Cell
    [cell configureUIWithCellModel:model];
    
    //附加的cellConfigure
    if (self.cellConfigure) {
        self.cellConfigure(cell, model, indexPath);
    }
    
    return cell;
}

 

@end
