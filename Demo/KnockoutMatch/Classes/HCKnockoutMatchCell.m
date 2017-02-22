//
//  HCKnockoutMatchCell.m
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "HCKnockoutMatchCell.h"

@implementation HCKnockoutMatchCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 1;
}

#pragma mark - Custom Method

- (void)displayDataWithModel:(id)model
{
    
}

@end
