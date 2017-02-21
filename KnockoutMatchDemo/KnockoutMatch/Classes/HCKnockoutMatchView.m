//
//  BFKnockoutMatchView.m
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "HCKnockoutMatchView.h"
#import "HCKnockoutMatchCell.h"
#import "HCKnockoutMatchManager.h"
#import "HCKnockoutMatchLayout.h"

#define KNOCKOUT_CELL_ID(a)                 [NSString stringWithFormat:@"CELL_ID_%ld",a]
#define KNOCKOUT_VIEW_BASE_TAG              1000
static NSString *KNOCKOUT_CELL_ID           = @"KNOCKOUT_CELL_ID";

@interface HCKnockoutMatchView ()<UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) HCKnockoutMatchManager *manager;
@property (assign, nonatomic) NSInteger teamCount;
@property (assign, nonatomic) BOOL isDouble;

@end
@implementation HCKnockoutMatchView

- (instancetype)initWithOrigin:(CGPoint)origin teamCount:(NSInteger)teamCount;
{
    self = [super init];
    if (self)
    {
        [self layoutViewWithTeamCount:teamCount origin:origin isShowThirdPlace:NO];
    }
    return self;
}

- (instancetype)initWithOrigin:(CGPoint)origin teamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShowThirdPlace
{
    self = [super init];
    if (self)
    {
        [self layoutViewWithTeamCount:teamCount origin:origin isShowThirdPlace:isShowThirdPlace];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin
{
    [self layoutViewWithTeamCount:teamCount origin:origin isShowThirdPlace:NO];
}

- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin isShowThirdPlace:(BOOL)isShowThirdPlace
{
    [self layoutViewWithTeamCount:teamCount origin:origin isShowThirdPlace:isShowThirdPlace isDouble:NO];
}

- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin isShowThirdPlace:(BOOL)isShowThirdPlace isDouble:(BOOL)isDouble
{
    _teamCount = teamCount;
    _isDouble = isDouble;
    _manager = [[HCKnockoutMatchManager alloc] initWithTeamCount:_teamCount isShowThirdPlace:isShowThirdPlace];
    self.frame = CGRectMake(origin.x, origin.y, [_manager viewWidth], [_manager viewHeight]);
    [self loadSubViews];
}

- (void)loadSubViews
{
    self.backgroundColor = [UIColor colorWithRed:249/255.0 green:250/255.0 blue:251/255.0 alpha:1];
    for (NSInteger i = 0; i < [self columCount]; i ++)
    {
        HCKnockoutMatchLayout *layout = [[HCKnockoutMatchLayout alloc] init];
        layout.viewCentersArray = _manager.centersArray[i];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(i*KNOCKOUT_COLUM_WIDTH + i*KNOCKOUT_COLUM_MARGIN, 0, KNOCKOUT_COLUM_WIDTH, [_manager viewHeight]) collectionViewLayout:layout];
        collectionView.backgroundColor = self.backgroundColor;
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HCKnockoutMatchCell class]) bundle:nil]forCellWithReuseIdentifier:KNOCKOUT_CELL_ID];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = i + KNOCKOUT_VIEW_BASE_TAG;
        collectionView.scrollEnabled = NO;
        [self addSubview:collectionView];
    }
}

- (NSInteger)columCount
{
    //return log(_teamCount)/log(2) + 1;//假设teamCount = 16 （16 - 8 - 4 - 2 - 1）
    return self.manager.matchRoundCount;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger tag = collectionView.tag - KNOCKOUT_VIEW_BASE_TAG;
    NSArray *centersArray = _manager.centersArray[tag];
    return centersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCKnockoutMatchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KNOCKOUT_CELL_ID forIndexPath:indexPath];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dataSourceForKnockoutMatchViewAtColumIndex:)])
    {
        NSArray *dataSourceArray = [self.dataSource dataSourceForKnockoutMatchViewAtColumIndex:collectionView.tag - KNOCKOUT_VIEW_BASE_TAG];
        if (dataSourceArray && dataSourceArray.count)
        {
            id model = dataSourceArray.count > indexPath.row ? dataSourceArray[indexPath.row] : nil;
            [cell displayDataWithModel:model];
        }else
        {
            [cell displayDataWithModel:nil];
        }
    }else
    {
        [cell displayDataWithModel:nil];
    }
    return cell;
}

//#pragma mark - UICollectionViewFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(KNOCKOUT_COLUM_WIDTH, KNOCKOUT_COLUM_HEIGHT);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2*[self itemLineSpaceByColumIndex:collectionView.tag - 100];
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    CGFloat margin = [self itemLineSpaceByColumIndex:collectionView.tag - 100];
//    return UIEdgeInsetsMake(margin, 0, margin, 0);
//}

@end
