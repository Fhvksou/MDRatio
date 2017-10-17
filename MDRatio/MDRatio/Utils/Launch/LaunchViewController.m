//
//  LaunchViewController.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/13.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "LaunchViewController.h"
#import "LaunchCollectionViewCell.h"

#define identify @"START_PICTURE"

@interface LaunchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LaunchCollectionViewCellDelegate>

@property (nonatomic ,strong) NSMutableArray * datas;
@property (nonatomic ,strong) MJRefreshCollectionView * collectionVc;
@property (nonatomic ,strong) UICollectionViewFlowLayout * layout;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initDatas];
}

- (void)initViews{
    [self.contentView addSubview:self.collectionVc];
}

- (void)initDatas{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"LaunchConfig" ofType:@"plist"];
    NSArray * images = [NSArray arrayWithContentsOfFile:path];
    [self.datas addObjectsFromArray:images];
}

#pragma mark UICollectionDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LaunchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateWithImageUrl:[self.datas objectAtIndex:indexPath.row]];
    if (indexPath.item == self.datas.count - 1) {
        [cell hidenStartButton:NO];
    }else{
        [cell hidenStartButton:YES];
    }
    return cell;
}

- (void)clickStartAppButton{
    if (_delegate && [_delegate respondsToSelector:@selector(dismissLaunchViewController)]) {
        [_delegate dismissLaunchViewController];
    }
}

#pragma mark lazyLoad

- (MJRefreshCollectionView *)collectionVc{
    if (!_collectionVc) {
        _collectionVc = [[MJRefreshCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:self.layout];
        _collectionVc.bounces = NO;
        _collectionVc.pagingEnabled = YES;
        _collectionVc.showsVerticalScrollIndicator = NO;
        _collectionVc.showsHorizontalScrollIndicator = NO;
        _collectionVc.delegate = self;
        _collectionVc.dataSource = self;
        [_collectionVc registerClass:[LaunchCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return _collectionVc;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
    }
    return _layout;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
