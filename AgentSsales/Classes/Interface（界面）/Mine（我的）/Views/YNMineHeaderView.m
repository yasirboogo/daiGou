//
//  YNMineHeaderView.m
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNMineHeaderView.h"

@interface YNMineHeaderView ()
{
    UIImageView *_headImgView;
    UILabel *_nameLabel;
    UILabel *_moneyLabel;
}
@property (nonatomic,strong)NSArray<NSDictionary*> *btnInfors;
@end

@implementation YNMineHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.frame = CGRectMake(0, 0, SCREEN_HEIGHT, W_RATIO(345)+W_RATIO(155));
        [self makeUI];
    }
    return self;
}
-(NSArray<NSDictionary *> *)btnInfors{
    if (!_btnInfors) {
        _btnInfors = @[@{@"title":LocalAllOrder,@"image":@"quanbu_wode"},
                       @{@"title":LocalWaitHandle,@"image":@"daifukuan_wode"},
                       @{@"title":LocalWaitPay,@"image":@"daichuli_wode"},
                       @{@"title":LocalWaitPPay,@"image":@"daifukuan_wode"},
                       @{@"title":LocalWaitSend,@"image":@"daifahuo_wode"},
                       @{@"title":LocalWaitReceive,@"image":@"daishouhuo_wode"},
                       @{@"title":LocalCompleted,@"image":@"yiwancheng_wode"}];
    }
    return _btnInfors;
}

-(void)makeUI{
    //第一部分
    UIImageView * topImgView = [[UIImageView alloc] init];
    topImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(345));
    topImgView.image = [UIImage imageNamed:@"beijing_wode"];
    [self addSubview:topImgView];
    
    CGFloat ringWidth = W_RATIO(3);
    UIView *ringView = [[UIView alloc] init];
    [topImgView addSubview:ringView];
    ringView.backgroundColor = COLOR_FFFFFF;
    
    ringView.frame = CGRectMake(W_RATIO(55),
                                W_RATIO(120),
                                W_RATIO(146),
                                W_RATIO(146));
    ringView.layer.cornerRadius = WIDTHF(ringView)/2.0;
    ringView.layer.masksToBounds = YES;
    
    _headImgView = [[UIImageView alloc] init];
    [ringView addSubview:_headImgView];
    _headImgView.frame = CGRectMake(ringWidth,
                                   ringWidth,
                                   WIDTHF(ringView)-ringWidth*2,
                                   WIDTHF(ringView)-ringWidth*2);
    _headImgView.layer.cornerRadius = WIDTHF(_headImgView)/2.0;
    _headImgView.layer.masksToBounds = YES;
    
    _nameLabel = [[UILabel alloc] init];
    [topImgView addSubview:_nameLabel];
    _nameLabel.frame = CGRectMake(MaxXF(ringView)+XF(ringView), YF(ringView), SCREEN_WIDTH-MaxXF(ringView)-XF(ringView)*2, WIDTHF(ringView)/2.0);
    _nameLabel.font = FONT(40);
    _nameLabel.textColor = COLOR_FFFFFF;
    _nameLabel.text = @"hello,frends";
    
    _moneyLabel = [[UILabel alloc] init];
    [topImgView addSubview:_moneyLabel];
    _moneyLabel.frame = CGRectMake(XF(_nameLabel), MaxYF(_nameLabel), WIDTHF(_nameLabel), WIDTHF(ringView)/3.0);
    _moneyLabel.font = FONT(30);
    _moneyLabel.textColor = COLOR_FFFFFF;
    _moneyLabel.text = [NSString stringWithFormat:@"%@%@ %@",LocalAccountLast,@"0.00",LocalMoneyType];
    
    //第二部分
    UIScrollView *btnScrView = [[UIScrollView alloc] init];
    [self addSubview:btnScrView];
    btnScrView.frame = CGRectMake(0, MaxYF(topImgView), SCREEN_WIDTH, HEIGHTF(self)-HEIGHTF(topImgView));
    btnScrView.showsHorizontalScrollIndicator = NO;
    btnScrView.bounces = NO;
    btnScrView.contentSize = CGSizeZero;
    
    [self.btnInfors enumerateObjectsUsingBlock:^(NSDictionary * btnInfor, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *scrViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrViewBtn setTitle:btnInfor[@"title"] forState:UIControlStateNormal];
        [scrViewBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [scrViewBtn setImage:[UIImage imageNamed:btnInfor[@"image"]] forState:UIControlStateNormal];
        [scrViewBtn addTarget:self action:@selector(handleScrollViewButtonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        scrViewBtn.titleLabel.font = FONT(24);
        scrViewBtn.tag = idx;
        scrViewBtn.frame = CGRectMake(btnScrView.contentSize.width, 0, HEIGHTF(btnScrView),HEIGHTF(btnScrView));
        btnScrView.contentSize = CGSizeMake(MaxXF(scrViewBtn), HEIGHTF(scrViewBtn));
        [btnScrView addSubview:scrViewBtn];
        [scrViewBtn adjustButtonForImageAndTitleWithImagePosition:BtnWithImgVerticalAbove isSpace:NO];
    }];
}
-(void)handleScrollViewButtonClickMethod:(UIButton*)btn{
    if (self.didSelectScrollViewButtonClickBlock) {
        self.didSelectScrollViewButtonClickBlock(btn.tag);
    }
}

-(void)setHeadImg:(NSString *)headImg{
    _headImg = headImg;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:headImg] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    
}
-(void)setNickName:(NSString *)nickName{
    _nickName = nickName;
    _nameLabel.text = nickName;
}
-(void)setRestMoney:(NSString *)restMoney{
    _restMoney = restMoney;
    _moneyLabel.text = [NSString stringWithFormat:@"%@%@ %@",LocalAccountLast,restMoney,LocalMoneyType];
}
@end
