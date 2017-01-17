//
//  YNOrderDetailsCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderDetailsCollectionView.h"
#import "YNGoodsCartCollectionView.h"

@interface YNOrderDetailsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong) NSArray * manMsgArray;
@property (nonatomic,strong) NSArray * orderMsgArray;
@property (nonatomic,strong) NSDictionary * goodsMsgDict;

@end

@implementation YNOrderDetailsCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(185));
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self registerClass:[YNDetailsManMsgCell class] forCellWithReuseIdentifier:@"manMsgCell"];
    
    [self registerClass:[YNDetailsOrderMsgCell class] forCellWithReuseIdentifier:@"orderMsgCell"];
    
    [self registerClass:[YNOrderGoodsCell class] forCellWithReuseIdentifier:@"goodsMsgCell"];
    
    [self registerClass:[YNOrderDetailsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self registerClass:[YNOrderDetailsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];

    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.manMsgArray = [YNManMsgCellFrame initWithFromDictionaries:@[dict[@"manMsg"]]];
    self.orderMsgArray = [YNOrderMsgCellFrame initWithFromDictionaries:@[dict[@"orderMsg"]]];
    self.goodsMsgDict = dict[@"goodsMsg"];
    [self reloadData];
}
#pragma mark - UITableView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.viewScrollBlock) {
        CGFloat alpha = (scrollView.contentOffset.y)/(self.contentSize.height - HEIGHTF(self));
        self.viewScrollBlock(alpha);
//        self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
//        if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {
//            //向上滑动,视图消失
//        }else if (scrollView.contentOffset.y < self.offsetY ){
//            //向下滑动，视图出现
//        }
//        self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNManMsgCellFrame *cellFrame = self.manMsgArray[0];
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2,cellFrame.cellHeight);
    }else if (indexPath.section == 1){
        YNOrderMsgCellFrame *cellFrame = self.orderMsgArray[0];
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2,cellFrame.cellHeight);
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, cellFrame.cellHeight);
    }else if (indexPath.section == 2){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(185));
    }else if (indexPath.section == 3){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(300));
    }
    return CGSizeZero;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return CGSizeZero;
    }
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(86)+W_RATIO(20));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 2){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(90));
    }
    return CGSizeZero;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNOrderDetailsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.dict = @{@"image":@"shouhuoren_dingdan",@"tips":@"收货人信息"};
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (indexPath.section == 2) {
            YNOrderDetailsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            footerView.dict = @{@"name":@"淘宝商城",@"price":@"500.12"};
            return footerView;
        }
    }
    return nil;

}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNDetailsManMsgCell *manMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"manMsgCell" forIndexPath:indexPath];
        manMsgCell.cellFrame = self.manMsgArray[0];
        return manMsgCell;
    }else if (indexPath.section == 1){
        YNDetailsOrderMsgCell *orderMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderMsgCell" forIndexPath:indexPath];
        orderMsgCell.cellFrame = self.orderMsgArray[0];
        return orderMsgCell;
    }else if (indexPath.section == 2){
        YNOrderGoodsCell *goodsMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsMsgCell" forIndexPath:indexPath];
        goodsMsgCell.dict = @{@"image":@"testGoods",@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"501.21",@"amount":@"2"};
        return goodsMsgCell;
    }else if (indexPath.section == 3){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}


@end

@implementation YNManMsgCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    CGSize nameSize = [dict[@"name"] calculateHightWithFont:FONT(34) maxWidth:W_RATIO(400)];
    self.nameF = CGRectMake(kMaxSpace, kMidSpace, nameSize.width, nameSize.height);
    
    self.phoneF = CGRectMake(MaxX(_nameF)+kMinSpace,Y(_nameF),SCREEN_WIDTH-W_RATIO(20)*2-kMidSpace-MaxX(_nameF)-kMidSpace ,HEIGHT(_nameF));
    
    CGSize addressSize = [dict[@"address"] calculateHightWithWidth:MaxX(_phoneF)-kMidSpace font:FONT(30)];
    self.addresssF = CGRectMake(X(_nameF),MaxY(_nameF)+W_RATIO(20),addressSize.width,addressSize.height);
    
    self.bgViewF = CGRectMake(0,0, SCREEN_WIDTH-W_RATIO(20)*2, MaxY(_addresssF)+kMidSpace);
    
    self.cellHeight = MaxY(_bgViewF);
}

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNManMsgCellFrame *cellFrame = [[YNManMsgCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}

@end

@interface YNDetailsManMsgCell ()

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,weak) UILabel *nameLabel;

@property (nonatomic,weak) UILabel *phoneLabel;

@property (nonatomic,weak) UILabel *addressLabel;

@end
@implementation YNDetailsManMsgCell

-(void)setCellFrame:(YNManMsgCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}

-(void)setupCellFrame:(YNManMsgCellFrame*)cellFrame{
    self.bgView.frame = cellFrame.bgViewF;
    self.nameLabel.frame = cellFrame.nameF;
    self.phoneLabel.frame = cellFrame.phoneF;
    self.addressLabel.frame = cellFrame.addresssF;
    
    [_bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];

}
-(void)setupCellContent:(YNManMsgCellFrame*)cellFrame{
    
    self.nameLabel.text = cellFrame.dict[@"name"];
    self.phoneLabel.text = cellFrame.dict[@"phone"];
    self.addressLabel.text = cellFrame.dict[@"address"];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView= bgView;
        [self.contentView addSubview:bgView];
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = COLOR_FFFFFF;
    }
    return _bgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.bgView addSubview:nameLabel];
        nameLabel.font = FONT(34);
        nameLabel.textColor = COLOR_333333;
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] init];
        _phoneLabel = phoneLabel;
        [self.bgView addSubview:phoneLabel];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.font = FONT(34);
        phoneLabel.textColor = COLOR_333333;
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        UILabel *addressLabel = [[UILabel alloc] init];
        _addressLabel = addressLabel;
        [self.bgView addSubview:addressLabel];
        addressLabel.numberOfLines = 0;
        addressLabel.font = FONT(30);
        addressLabel.textColor = COLOR_333333;
    }
    return _addressLabel;
}


@end

@implementation YNOrderMsgCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    NSArray<NSString*> *itemTitles = @[@"订单编号",@"下单时间",@"付款时间",@"发货地址",@"订单状态"];
    __block CGFloat maxWidth = 0;
    __block CGFloat maxHeight = 0;
    [itemTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull itemTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize itemSize = [itemTitle calculateHightWithFont:FONT(30) maxWidth:W_RATIO(200)];
        maxWidth = (itemSize.width > maxWidth)?itemSize.width:maxWidth;
        maxHeight = itemSize.height;
    }];
    
    self.codeLF = CGRectMake(kMaxSpace, kMidSpace, maxWidth, maxHeight);
    self.codeRF = CGRectMake(MaxX(_codeLF)+kMidSpace, Y(_codeLF),SCREEN_WIDTH-W_RATIO(20)*2-MaxX(_codeLF)-kMidSpace,HEIGHT(_codeLF) );
    
    self.buyTimeLF = CGRectMake(X(_codeLF), MaxY(_codeRF)+kMidSpace,  WIDTH(_codeLF),HEIGHT(_codeLF));
    self.buyTimeRF = CGRectMake(X(_codeRF), Y(_buyTimeLF), WIDTH(_codeRF),HEIGHT(_codeRF));
    
    self.payTimeLF = CGRectMake(X(_codeLF), MaxY(_buyTimeRF)+kMidSpace,  WIDTH(_codeLF),HEIGHT(_codeLF));
    self.payTimeRF = CGRectMake(X(_codeRF), Y(_payTimeLF), WIDTH(_codeRF),HEIGHT(_codeRF));
    
    self.addresssLF = CGRectMake(X(_codeLF), MaxY(_payTimeLF)+kMidSpace,  WIDTH(_codeLF),HEIGHT(_codeLF));
    
    CGSize addressSize = [dict[@"address"] calculateHightWithWidth:WIDTH(_codeRF) font:FONT(30)];
    
    self.addresssRF = CGRectMake(X(_codeRF), Y(_addresssLF), addressSize.width,addressSize.height);
    
    self.statusLF = CGRectMake(X(_codeLF), MaxY(_addresssRF)+kMidSpace,  WIDTH(_codeLF),HEIGHT(_codeLF));
    self.statusRF = CGRectMake(X(_codeRF), Y(_statusLF), WIDTH(_codeRF),HEIGHT(_codeRF));
    
    
    self.bgViewF = CGRectMake(0,0, SCREEN_WIDTH-W_RATIO(20)*2, MaxY(_statusRF)+kMidSpace);
    
    self.cellHeight = MaxY(_bgViewF);
}

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNOrderMsgCellFrame *cellFrame = [[YNOrderMsgCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}

@end

@interface YNDetailsOrderMsgCell ()

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,weak) UILabel *codeLLabel;

@property (nonatomic,weak) UILabel *codeRLabel;

@property (nonatomic,weak) UILabel *buyTimeLLabel;

@property (nonatomic,weak) UILabel *buyTimeRLabel;

@property (nonatomic,weak) UILabel *payTimeLLabel;

@property (nonatomic,weak) UILabel *payTimeRLabel;

@property (nonatomic,weak) UILabel *addressLLabel;

@property (nonatomic,weak) UILabel *addressRLabel;

@property (nonatomic,weak) UILabel *statusLLabel;

@property (nonatomic,weak) UILabel *statusRLabel;

@end
@implementation YNDetailsOrderMsgCell

-(void)setCellFrame:(YNOrderMsgCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}

-(void)setupCellFrame:(YNOrderMsgCellFrame*)cellFrame{
    self.bgView.frame = cellFrame.bgViewF;
    self.codeLLabel.frame = cellFrame.codeLF;
    self.codeRLabel.frame = cellFrame.codeRF;
    self.buyTimeLLabel.frame = cellFrame.buyTimeLF;
    self.buyTimeRLabel.frame = cellFrame.buyTimeRF;
    self.payTimeLLabel.frame = cellFrame.payTimeLF;
    self.payTimeRLabel.frame = cellFrame.payTimeRF;
    self.addressLLabel.frame = cellFrame.addresssLF;
    self.addressRLabel.frame = cellFrame.addresssRF;
    self.statusLLabel.frame = cellFrame.statusLF;
    self.statusRLabel.frame = cellFrame.statusRF;
    
    [_bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    
}
-(void)setupCellContent:(YNOrderMsgCellFrame*)cellFrame{
    
    NSArray<NSString*> *itemTitles = @[@"订单编号",@"下单时间",@"付款时间",@"发货地址",@"订单状态"];
    self.codeLLabel.text = itemTitles[0];
    self.codeRLabel.text = cellFrame.dict[@"code"];
    self.buyTimeLLabel.text = itemTitles[1];
    self.buyTimeRLabel.text = cellFrame.dict[@"buyTime"];
    self.payTimeLLabel.text = itemTitles[2];
    self.payTimeRLabel.text = cellFrame.dict[@"payTime"];
    self.addressLLabel.text = itemTitles[3];
    self.addressRLabel.text = cellFrame.dict[@"address"];
    self.statusLLabel.text = itemTitles[4];
    self.statusRLabel.text = cellFrame.dict[@"status"];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self.contentView addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(0, 0, WIDTHF(self.contentView), HEIGHTF(self.contentView));
    }
    return _bgView;
}

-(UILabel *)codeLLabel{
    if (!_codeLLabel) {
        UILabel *codeLLabel = [[UILabel alloc] init];
        _codeLLabel = codeLLabel;
        [self.bgView addSubview:codeLLabel];
        codeLLabel.textColor = COLOR_999999;
        codeLLabel.font = FONT(30);
    }
    return _codeLLabel;
}
-(UILabel *)codeRLabel{
    if (!_codeRLabel) {
        UILabel *codeRLabel = [[UILabel alloc] init];
        _codeRLabel = codeRLabel;
        [self.bgView addSubview:codeRLabel];
        codeRLabel.textColor = COLOR_333333;
        codeRLabel.font = FONT(30);
    }
    return _codeRLabel;
}
-(UILabel *)buyTimeLLabel{
    if (!_buyTimeLLabel) {
        UILabel *buyTimeLLabel = [[UILabel alloc] init];
        _buyTimeLLabel = buyTimeLLabel;
        [self.bgView addSubview:buyTimeLLabel];
        buyTimeLLabel.textColor = COLOR_999999;
        buyTimeLLabel.font = FONT(30);
    }
    return _buyTimeLLabel;
}
-(UILabel *)buyTimeRLabel{
    if (!_buyTimeRLabel) {
        UILabel *buyTimeRLabel = [[UILabel alloc] init];
        _buyTimeRLabel = buyTimeRLabel;
        [self.bgView addSubview:buyTimeRLabel];
        buyTimeRLabel.textColor = COLOR_333333;
        buyTimeRLabel.font = FONT(30);
    }
    return _buyTimeRLabel;
}
-(UILabel *)payTimeLLabel{
    if (!_payTimeLLabel) {
        UILabel *payTimeLLabel = [[UILabel alloc] init];
        _payTimeLLabel = payTimeLLabel;
        [self.bgView addSubview:payTimeLLabel];
        payTimeLLabel.textColor = COLOR_999999;
        payTimeLLabel.font = FONT(30);
    }
    return _payTimeLLabel;
}
-(UILabel *)payTimeRLabel{
    if (!_payTimeRLabel) {
        UILabel *payTimeRLabel = [[UILabel alloc] init];
        _payTimeRLabel = payTimeRLabel;
        [self.bgView addSubview:payTimeRLabel];
        payTimeRLabel.textColor = COLOR_333333;
        payTimeRLabel.font = FONT(30);
    }
    return _payTimeRLabel;
}
-(UILabel *)addressLLabel{
    if (!_addressLLabel) {
        UILabel *addressLLabel = [[UILabel alloc] init];
        _addressLLabel = addressLLabel;
        [self.bgView addSubview:addressLLabel];
        addressLLabel.textColor = COLOR_999999;
        addressLLabel.font = FONT(30);
    }
    return _addressLLabel;
}
-(UILabel *)addressRLabel{
    if (!_addressRLabel) {
        UILabel *addressRLabel = [[UILabel alloc] init];
        _addressRLabel = addressRLabel;
        [self.bgView addSubview:addressRLabel];
        addressRLabel.textColor = COLOR_333333;
        addressRLabel.font = FONT(30);
    }
    return _addressRLabel;
}
-(UILabel *)statusLLabel{
    if (!_statusLLabel) {
        UILabel *statusLLabel = [[UILabel alloc] init];
        _statusLLabel = statusLLabel;
        [self.bgView addSubview:statusLLabel];
        statusLLabel.textColor = COLOR_999999;
        statusLLabel.font = FONT(30);
    }
    return _statusLLabel;
}
-(UILabel *)statusRLabel{
    if (!_statusRLabel) {
        UILabel *statusRLabel = [[UILabel alloc] init];
        _statusRLabel = statusRLabel;
        [self.bgView addSubview:statusRLabel];
        statusRLabel.textColor = COLOR_DF463E;
        statusRLabel.font = FONT(30);
    }
    return _statusRLabel;
}
@end

@interface YNOrderDetailsHeaderView ()

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,weak) UIImageView *icoImgView;

@property (nonatomic,weak) UILabel *tipsLabel;

@end
@implementation YNOrderDetailsHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.icoImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.tipsLabel.text = dict[@"tips"];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self)-W_RATIO(20));
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _bgView;
}
-(UIImageView *)icoImgView{
    if (!_icoImgView) {
        UIImageView *icoImgView = [[UIImageView alloc] init];
        _icoImgView = icoImgView;
        [self.bgView addSubview:icoImgView];
        icoImgView.frame = CGRectMake(W_RATIO(20), HEIGHTF(_bgView)/4.0,HEIGHTF(_bgView)/2.0, HEIGHTF(_bgView)/2.0);
    }
    return _icoImgView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self.bgView addSubview:tipsLabel];
        tipsLabel.textColor = COLOR_666666;
        tipsLabel.font = FONT(28);
        tipsLabel.frame = CGRectMake(MaxXF(_icoImgView)+kMinSpace, 0, WIDTHF(_bgView)-MaxXF(_icoImgView)-kMinSpace, HEIGHTF(_bgView));
    }
    return _tipsLabel;
}

@end
@interface YNOrderDetailsFooterView ()

@property (nonatomic,weak) UIView * bgView;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * amountLabel;

@property (nonatomic,weak) UILabel * markLabel;

@property (nonatomic,weak) UILabel * priceLabel;

@end
@implementation YNOrderDetailsFooterView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.amountLabel.text = @"共计（不含邮费）：";
    self.markLabel.text = @"￥";
    self.nameLabel.text = dict[@"name"];
    self.priceLabel.text = dict[@"price"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:WIDTHF(_bgView)/4.0];
    self.nameLabel.frame = CGRectMake(W_RATIO(20), 0, nameSize.width, HEIGHTF(_bgView));
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:WIDTHF(_bgView)/3.0];
    self.priceLabel.frame = CGRectMake(WIDTHF(_bgView)-priceSize.width-W_RATIO(20),(HEIGHTF(_bgView)-priceSize.height)/2.0, priceSize.width, priceSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width-kMinSpace,MaxYF(_priceLabel)-markSize.height, markSize.width,markSize.height);
    
    self.amountLabel.frame = CGRectMake(MaxXF(_nameLabel)+kMinSpace,0, XF(_markLabel)-MaxXF(_nameLabel)-kMinSpace*2, HEIGHTF(_bgView));
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(W_RATIO(20), 0, WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self));
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _bgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.bgView addSubview:nameLabel];
        nameLabel.font = FONT(26);
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.textColor = COLOR_999999;
    }
    return _nameLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.font = FONT(26);
        amountLabel.adjustsFontSizeToFitWidth = YES;
        amountLabel.textAlignment = NSTextAlignmentRight;
        amountLabel.textColor = COLOR_999999;
    }
    return _amountLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_DF463E;
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.font = FONT(38);
        priceLabel.adjustsFontSizeToFitWidth = YES;
        priceLabel.textColor = COLOR_DF463E;
    }
    return _priceLabel;
}

@end
