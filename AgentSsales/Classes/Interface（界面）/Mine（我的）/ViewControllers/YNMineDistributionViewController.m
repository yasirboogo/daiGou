//
//  YNMineDistributionViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineDistributionViewController.h"
#import "YNUpdateInforViewController.h"
#import "YNDistributionTableView.h"
#import "YNMineImgHeaderView.h"

@interface YNMineDistributionViewController ()

@property (nonatomic,strong) YNMineImgHeaderView *headerView;

@property (nonatomic,weak) YNDistributionTableView *tableView;

@end

@implementation YNMineDistributionViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(YNMineImgHeaderView *)headerView{
    if (!_headerView) {
        YNMineImgHeaderView *headerView = [[YNMineImgHeaderView alloc] init];
        _headerView = headerView;
        [self.view addSubview:headerView];
    }
    return _headerView;
}

-(YNDistributionTableView *)tableView{
    if (!_tableView) {
        YNDistributionTableView *tableView = [[YNDistributionTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    self.headerView.topTitleLabel.text = @"佣金总额（元）";
    self.headerView.leftTitleLabel.text = @"历史佣金（元）";
    self.headerView.rightTitleLabel.text = @"我的粉丝（人）";
    
    self.headerView.topNumber = @"1024.22";
    
    self.headerView.leftNumber = @"1365.12";
    
    self.headerView.rightNumber = @"20";
    
    self.tableView.dataArray = @[@{@"time":@"2006.10.16",@"resouce":@"我是谁",@"money":@"20.01"},
                                 @{@"time":@"2006.10.16",@"resouce":@"我是谁",@"money":@"20.01"},
                                 @{@"time":@"2006.10.16",@"resouce":@"我是谁",@"money":@"20.01"},
                                 @{@"time":@"2006.10.16",@"resouce":@"我是谁",@"money":@"20.01"}];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;
    [self addNavigationBarBtnWithTitle:@"规则" selectTitle:@"规则" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        
    }];
    self.titleLabel.text = @"我的分销";
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
