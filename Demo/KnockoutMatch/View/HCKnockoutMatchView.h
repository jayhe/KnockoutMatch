//
//  BFKnockoutMatchView.h
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HCKnockoutMatchViewDataSource;
/**
 *  淘汰赛的视图
 */
@interface HCKnockoutMatchView : UIView

@property (weak, nonatomic)id <HCKnockoutMatchViewDataSource> dataSource;

- (instancetype)initWithOrigin:(CGPoint)origin teamCount:(NSInteger)teamCount;
- (instancetype)initWithOrigin:(CGPoint)origin teamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShowThirdPlace;
/**
 *  根据队伍数布局视图：这个是在视图初始化的时候，队伍数不确定的时候使用;默认不显示三四名争夺，如果要显示使用下面那个方法，isShowThirdPlace传YES
 *
 *  @param teamCount 队伍数
 *  @param origin    视图的起始坐标
 */
- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin;
- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin isShowThirdPlace:(BOOL)isShowThirdPlace;
- (void)layoutViewWithTeamCount:(NSInteger)teamCount origin:(CGPoint)origin isShowThirdPlace:(BOOL)isShowThirdPlace isDouble:(BOOL)isDouble;
@end

@protocol HCKnockoutMatchViewDataSource <NSObject>
/**
 *  设置view的数据源
 *
 *  @param colunIndex 列
 *
 *  @return 数据
 */
- (NSArray *)dataSourceForKnockoutMatchViewAtColumIndex:(NSInteger)colunIndex;

@end
