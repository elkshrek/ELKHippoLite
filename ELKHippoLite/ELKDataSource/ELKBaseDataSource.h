//
//  ELKBaseDataSource.h
//  ELKCommonDemo
//
//  Created by Maybe on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELKBaseTableViewCellModel.h"
#import "UITableViewCell+ELKDataSourceConfigure.h"
#import "UICollectionViewCell+ELKDataSourceConfigure.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ELKDataBaseLoadDelegate <NSObject>

/// 分页加载实现
/// @param page 当前页码
/// @param loadOver 加载完成后block( success:是否成功 isAllLoad:是否全部加载)
- (void)loadDataWithPage:(NSInteger)page overAction:(void (^_Nonnull)(BOOL success, BOOL isAllLoad))loadOver;

@end

typedef void (^CellConfigure)(id cell, id model, NSIndexPath * indexPath);
typedef NSUInteger (^NumberOfCellSection)(NSUInteger section);
typedef ELKBaseTableViewCellModel* _Nonnull (^CellModelOfIndexPath)(NSIndexPath * indexPath);
typedef NSUInteger (^NumberOfSection)(void);

@interface ELKBaseDataSource : NSObject<UITableViewDataSource, UICollectionViewDataSource>
 

/// 分页加载 - 当前页码
@property (nonatomic, assign) NSInteger page;
/// 分页加载 - 每页大小
@property (nonatomic, assign) NSInteger pageSize;
/// 是否全部加载完成
@property (nonatomic, assign) BOOL isAllLoad;
/// 设置cell内容的block
@property (nonatomic, copy) CellConfigure cellConfigure;
/// 返回对应setion的cell数量的block
@property (nonatomic, copy) NumberOfCellSection numberOfCellSection;

/// 返回setion数量的block
@property (nonatomic, copy) NumberOfSection numberOfSection;

/// 返回对应IndexPath的cellModel的block
@property (nonatomic, copy) CellModelOfIndexPath cellModelOfIndexPath;
/// 加载更多 刷新的代理
@property (nonatomic, weak) id<ELKDataBaseLoadDelegate> delegate;

/// 初始化tableView的Datasource
/// @param tableView tableView
/// @param cellModelOfIndexPath 返回对应IndexPath的cellModel的block
/// @param numberOfCellSection 返回对应setion的cell数量的block
- (instancetype)initWithTableView:(UITableView *)tableView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection;

/// 初始化tableView的Datasource - 加cellConfigure
/// @param tableView tableView
/// @param cellModelOfIndexPath 返回对应IndexPath的cellModel的block
/// @param numberOfCellSection 返回对应setion的cell数量的block
/// @param cellConfigure 设置cell内容的block (可以不传，默认会调用cell的configureUIWithDataModel:)
- (instancetype)initWithTableView:(UITableView *)tableView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection  cellConfigure:(_Nullable CellConfigure)cellConfigure ;


/// 初始化collectionView的Datasource - 加cellConfigure
/// @param collectionView tableView
/// @param cellModelOfIndexPath 返回对应IndexPath的cellModel的block
/// @param numberOfCellSection 返回对应setion的cell数量的block
/// @param cellConfigure 设置cell内容的block (可以不传，默认会调用cell的configureUIWithDataModel:)
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView CellModel:(CellModelOfIndexPath)cellModelOfIndexPath rowNumberOfSection:(NumberOfCellSection)numberOfCellSection  cellConfigure:(_Nullable CellConfigure)cellConfigure ;



/// 设置下拉刷新 上拉加载
/// @param refresh 是否支持下拉刷新
/// @param loadMore 是否支持上拉加载
/// @param begainRefreshing 是否自动开始刷新(加载第一页)
/// @param delegate 代理
- (void)setupPullDownToRefresh:(BOOL)refresh pullUpToLoadMore:(BOOL)loadMore autoBegainRefreshing:(BOOL)begainRefreshing delegate:(id <ELKDataBaseLoadDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
