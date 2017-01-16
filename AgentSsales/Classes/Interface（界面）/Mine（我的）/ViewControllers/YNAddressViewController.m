//
//  YNAdressViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAddressViewController.h"
#import "YNNewAddressViewController.h"
#import "YNAddressTableView.h"

@interface YNAddressViewController ()

@property (nonatomic,weak) YNAddressTableView * tableView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

@end

@implementation YNAddressViewController
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
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
-(YNAddressTableView *)tableView{
    if (!_tableView) {
        YNAddressTableView *tableView = [[YNAddressTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^(NSIndexPath *indexPath) {
            YNNewAddressViewController *pushVC = [[YNNewAddressViewController alloc] init];
            pushVC.titleStr = @"修改收货地址";
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kUINavHeight);
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudizhi"];
        emptyView.tips = @"暂无收货地址";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    self.tableView.dataArrayM = [NSMutableArray arrayWithArray:@[
    @{@"name":@"李小龙",@"phone":@"13631499999",@"address":@"广东省广州市天河区五山街华南农业大学花山区12栋312"},
    @{@"name":@"李小龙",@"phone":@"13631499999",@"address":@"广东省广州市天河区五山街华南农业大学花山区12栋312"}
    ]];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"新建" selectTitle:@"新建" font:FONT_15 img:[UIImage imageNamed:@"xinjian"] selectImg:[UIImage imageNamed:@"xinjian"] imgWidth:W_RATIO(30) isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNNewAddressViewController *pushVC = [[YNNewAddressViewController alloc] init];
        pushVC.titleStr = @"新增收货地址";
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.titleLabel.text = @"收货地址管理";
}
-(void)makeUI{
    [super makeUI];

    self.emptyView.hidden = _tableView.dataArrayM.count;
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end

