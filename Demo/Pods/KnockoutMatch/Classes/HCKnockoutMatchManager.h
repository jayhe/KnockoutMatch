//
//  HCKnockoutMatchManager.h
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define KNOCKOUT_COLUM_WIDTH                            210.0
#define KNOCKOUT_COLUM_HEIGHT                           60.0
#define KNOCKOUT_COLUM_MARGIN                           15.0
#define KNOCKOUT_FIRST_COLUM_HORIZONTAL_MARGIN          5.0
#define KNOCKOUT_FIRST_COLUM_BIG_HORIZONTAL_MARGIN      70.0
/**
 *  该类用来管理淘汰赛的视图每个单元格的中心点位置
 */
@interface HCKnockoutMatchManager : NSObject
/**
 *  二维数组，里面是每列的单元格的中心坐标数组
 */
@property (strong, nonatomic, readonly) NSArray *centersArray;
@property (assign, nonatomic, readonly) NSInteger matchRoundCount;

- (instancetype)initWithTeamCount:(NSInteger)teamCount;

/**
 *  初始化淘汰赛的对战信息
 *
 *  @param teamCount 队伍数
 *  @param isShow    是否展示季军争夺
 *
 *  @return 返回实例
 */
- (instancetype)initWithTeamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShow;

- (CGFloat)viewWidth;
/**
 *  对战视图的高度
 *
 *  @return 高度
 */
- (CGFloat)viewHeight;
/**
 *  对战视图的高度
 *
 *  @param teamCount 队伍数
 *  @param isShow    是否展示三四名争夺
 *
 *  @return 高度
 */
+ (CGFloat)viewHeightWithTeamCount:(NSInteger)teamCount isShowThirdPlace:(BOOL)isShow;

@end
