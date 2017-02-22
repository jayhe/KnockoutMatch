//
//  HCKnockoutMatchLayout.m
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "HCKnockoutMatchLayout.h"
#import "HCKnockoutMatchManager.h"

@implementation HCKnockoutMatchLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(KNOCKOUT_COLUM_WIDTH,KNOCKOUT_COLUM_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(0, 0.0, 0, 0.0);//上下边距
        self.minimumLineSpacing = .1;
    }
    
    return self;
}

//布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //取父类的UICollectionViewLayoutAttributes
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    for (NSInteger i = 0 ;i < array.count; i ++)
    {
        UICollectionViewLayoutAttributes* attributes = array[i];
        CGPoint originCenter = attributes.center;
        NSValue *centerValue = i < _viewCentersArray.count? _viewCentersArray[i]:nil;
        CGPoint center = (centerValue?[centerValue CGPointValue]:CGPointZero);
        if (center.x != 0 && center.y != 0)
        {
            originCenter.y = center.y;
        }
        attributes.center = originCenter;
    }
    
    return array;
}

@end
