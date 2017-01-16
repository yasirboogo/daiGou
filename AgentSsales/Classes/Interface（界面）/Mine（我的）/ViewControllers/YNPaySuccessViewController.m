//
//  YNPaySuccessViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPaySuccessViewController.h"
#import "YNTipsSuccessTopView.h"
#import "YNTipsSuccessMsgView.h"
#import "YNTipsSuccessBtnsView.h"

@interface YNPaySuccessViewController ()

@property (nonatomic,weak) YNTipsSuccessTopView * topView;

@property (nonatomic,weak) YNTipsSuccessMsgView * msgView;

@property (nonatomic,weak) YNTipsSuccessBtnsView * btnsView;

@end

@implementation YNPaySuccessViewController

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
-(YNTipsSuccessTopView *)topView{
    if (!_topView) {
        YNTipsSuccessTopView *topView =[[YNTipsSuccessTopView alloc] init];
        _topView = topView;
        [self.view addSubview:topView];
    }
    return _topView;
}
-(YNTipsSuccessMsgView *)msgView{
    if (!_msgView) {
        YNTipsSuccessMsgView *msgView = [[YNTipsSuccessMsgView alloc] init];
        _msgView = msgView;
        [self.view addSubview:msgView];
    }
    return _msgView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.btnStyle = UIButtonStyle1;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
    }
    return _btnsView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    if ([self.titleStr isEqualToString:@"支付成功"]) {
        //第一部分
        self.topView.dict = @{@"image":@"chongzhichenggong",@"tips":@"恭喜你，支付成功!"};
        //第二部分
        NSString *tips = @"您充值的[200元人民币]已成功存入我的钱包，并赠送了[20元优惠劵]，请前往查看。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        [msgAttributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_DF463E} range:NSMakeRange(4, 9)];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"送货成功",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"返回首页",@"查看订单"];
    }else if ([self.titleStr isEqualToString:@"兑换成功"]){
        //第一部分
        self.topView.dict = @{@"image":@"duihuanchenggong",@"tips":@"恭喜你，兑换成功!"};
        //第二部分
        NSString *tips = @"您兑换的[231.15元美元]已成功存入我的钱包，请前往查看。";
        CGSize msgSize = [tips calculateHightWithWidth:WIDTHF(_topView)-kMidSpace*2 font:FONT(28)];
        
        NSMutableAttributedString *msgAttributedStrM = [[NSMutableAttributedString alloc] initWithString:tips];
        [msgAttributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_DF463E} range:NSMakeRange(4, 11)];
        
        self.msgView.msgSize = msgSize;
        self.msgView.dict = @{@"title":@"兑换成功",@"msg":msgAttributedStrM};
        //第三部分
        self.btnsView.btnTitles = @[@"查看我的钱包"];
    }
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = self.titleStr;
}
-(void)makeUI{
    [super makeUI];

}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
