//
//  HCKnockoutMatchManager.m
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "HCKnockoutMatchManager.h"
#import <CoreGraphics/CoreGraphics.h>

@interface HCKnockoutMatchManager()

@property (assign, nonatomic) NSInteger teamCount;
@property (assign, nonatomic) NSInteger roundCount;
@property (strong, nonatomic) NSMutableArray *roundCentersArray;
@property (assign, nonatomic) BOOL isShowThirdPlace;//是否展示季军争夺

@end

@implementation HCKnockoutMatchManager

- (instancetype)initWithTeamCount:(NSInteger)teamCount
{
    return [self initWithTeamCount:teamCount isShowThirdPlace:NO];
}

- (instancetype)initWithTeamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShow
{
    self = [super init];
    if (self)
    {
        _teamCount = teamCount;
        _roundCount = 0;
        _roundCentersArray = [NSMutableArray array];
        _isShowThirdPlace = isShow;
        [self configRoundCountWithTeamCount:teamCount];
        [self configItemsCenter];
    }
    return self;
}

- (NSArray *)centersArray
{
    return _roundCentersArray;
}

- (NSInteger)matchRoundCount
{
    return _roundCount;
}

/**
 *  计算淘汰赛的每个item的中心坐标，这里的centerX是针对父视图（用scrollView循环加载可以用centerX），采用的是多个collectionView，每列就是一个collectionView，这种情况就只需要使用centerY属性。
 */
- (void)configItemsCenter
{
    NSInteger itemsCount = _teamCount;//itemsCount:对战块的个数
    for (NSInteger round = 0; round < _roundCount; round ++)
    {
        NSMutableArray *preRoundArray;
        NSMutableArray *roundArray = [NSMutableArray array];
        if (_roundCentersArray.count && _roundCentersArray.count >= round)
        {
            preRoundArray = _roundCentersArray[round-1];
        }
        /* eg:  8只队伍 对战依次是 4组 2组 1组
         *      9只队伍 对战依次是 5组 3组 2组 1组
         */
        itemsCount = ceil(itemsCount/2.0);//下一轮的个数是上一轮的个数除2取上整
        //如果展示三四名争夺，最后一轮的时候需要展示2个对战信息
        if (_isShowThirdPlace && itemsCount == 1 && _teamCount >= 4)
        {
            itemsCount = 2;//用于显示季军
        }
        for (NSInteger itemIndex = 0; itemIndex < itemsCount; itemIndex ++)
        {
            if (preRoundArray && preRoundArray.count)
            {
                if (itemIndex*2+1 < preRoundArray.count)
                {
                    NSValue *homeTeamValue = preRoundArray[itemIndex*2];
                    NSValue *awayTeamValue = preRoundArray[itemIndex*2+1];
                    CGPoint homeTeamCenter = [homeTeamValue CGPointValue];
                    CGPoint awayTeamCenter = [awayTeamValue CGPointValue];
                    CGFloat centerX = ((round+1)*KNOCKOUT_COLUM_WIDTH)/2+KNOCKOUT_COLUM_MARGIN*(round+1);
                    CGFloat centerY = (homeTeamCenter.y + awayTeamCenter.y)/2;
                    CGPoint center = CGPointMake(centerX, centerY);
                    [roundArray addObject:[NSValue valueWithCGPoint:center]];
                }else
                {
                    //最后一个单的，轮空的就直接跟前一轮的最后一个对齐
                    NSValue *homeTeamValue = preRoundArray.lastObject;
                    [roundArray addObject:homeTeamValue];
                }
            }else
            {
                //第一轮
                if (_isShowThirdPlace && _teamCount <=4 && _teamCount > 2)
                {
                    //显示三四名比赛，第一轮的间距设置大一些，使得三四名的可以有位置展示
                    CGFloat centerX = KNOCKOUT_COLUM_WIDTH/2 + KNOCKOUT_COLUM_MARGIN;
                    CGFloat centerY = KNOCKOUT_COLUM_HEIGHT/2 + itemIndex*KNOCKOUT_COLUM_HEIGHT + KNOCKOUT_FIRST_COLUM_BIG_HORIZONTAL_MARGIN*itemIndex;
                    CGPoint center = CGPointMake(centerX, centerY);
                    [roundArray addObject:[NSValue valueWithCGPoint:center]];
                }else
                {
                    CGFloat centerX = KNOCKOUT_COLUM_WIDTH/2 + KNOCKOUT_COLUM_MARGIN;
                    CGFloat centerY = KNOCKOUT_COLUM_HEIGHT/2 + itemIndex*KNOCKOUT_COLUM_HEIGHT + KNOCKOUT_FIRST_COLUM_HORIZONTAL_MARGIN*itemIndex;
                    CGPoint center = CGPointMake(centerX, centerY);
                    [roundArray addObject:[NSValue valueWithCGPoint:center]];
                }
            }
        }
        [_roundCentersArray addObject:roundArray];
    }
}

/**
 *  根据队伍数获取轮次数
 *
 *  @param teamCount 队伍数
 */
- (void)configRoundCountWithTeamCount:(NSInteger)teamCount
{
    if(teamCount>1)
    {
        teamCount = ceil(teamCount/2.0);
        _roundCount++;
        [self configRoundCountWithTeamCount:teamCount];
    }
}

- (CGFloat)viewWidth
{
    return (KNOCKOUT_COLUM_WIDTH*_roundCount + KNOCKOUT_COLUM_MARGIN*(_roundCount - 1));
}

- (CGFloat)viewHeight
{
    NSInteger count =  ceil(_teamCount/2.0);
    if (count == 0)
    {
        return 0;
    }
    CGFloat margin = _isShowThirdPlace?KNOCKOUT_FIRST_COLUM_BIG_HORIZONTAL_MARGIN:KNOCKOUT_FIRST_COLUM_HORIZONTAL_MARGIN;
    return (KNOCKOUT_COLUM_HEIGHT*count + margin*(count - 1));
}

+ (CGFloat)viewHeightWithTeamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShow
{
    NSInteger count =  ceil(teamCount/2.0);
    if (count == 0)
    {
        return 0;
    }
    CGFloat margin = isShow?KNOCKOUT_FIRST_COLUM_BIG_HORIZONTAL_MARGIN:KNOCKOUT_FIRST_COLUM_HORIZONTAL_MARGIN;
    return (KNOCKOUT_COLUM_HEIGHT*count + margin*(count - 1));
}

@end
