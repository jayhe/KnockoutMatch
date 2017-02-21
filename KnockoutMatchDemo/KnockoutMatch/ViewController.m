//
//  ViewController.m
//  KnockoutMatch
//
//  Created by hechao on 17/2/21.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "ViewController.h"
#import "HCKnockoutMatchView.h"

@interface ViewController ()<HCKnockoutMatchViewDataSource>

@property (strong, nonatomic) UIScrollView *containerView;
@property (strong, nonatomic) HCKnockoutMatchView *knockoutView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action



#pragma mark - Http



#pragma mark - BFKnockoutMatchViewDataSource

- (NSArray *)dataSourceForKnockoutMatchViewAtColumIndex:(NSInteger)columIndex
{
    //设置dataSource，是一个二维数组
    return @[@[],
             @[],
             @[],
             @[]];
}



#pragma mark - Private Methods



#pragma mark - UI

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //add subview
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.knockoutView];
    //set frame
    _containerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _containerView.contentSize = CGSizeMake(_knockoutView.frame.size.width + 0*2, _knockoutView.frame.size.height);
}

#pragma mark - Getter && Setter

- (UIScrollView *)containerView
{
    if (_containerView == nil)
    {
        _containerView = [[UIScrollView alloc] init];
        _containerView.backgroundColor = [UIColor colorWithRed:249/255.0 green:250/255.0 blue:251/255.0 alpha:1];
        _containerView.directionalLockEnabled = YES;
    }
    
    return _containerView;
}

- (HCKnockoutMatchView *)knockoutView
{
    if (_knockoutView == nil)
    {
        _knockoutView = [[HCKnockoutMatchView alloc] init];
        _knockoutView.dataSource = self;
        //设置布局
        [_knockoutView layoutViewWithTeamCount:8 origin:CGPointMake(10, 150) isShowThirdPlace:NO isDouble:NO];
    }
    
    return _knockoutView;
}


@end
