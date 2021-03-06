//
//  YNOrderDetailsCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNOrderDetailsCollectionView : UICollectionView

@property (nonatomic,strong) NSDictionary *detailDict;

@property (nonatomic,strong) MyOrderListModel *myOrderListModel;

@property (nonatomic,strong) void(^viewScrollBlock)(CGFloat alpha);

@property (nonatomic,copy) void (^viewDidDisappearStopTimerBlock)();

@property (nonatomic,copy) void (^buttonNoClickStopTimerBlock)();

@end


@interface YNManMsgCellFrame : NSObject

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect phoneF;
@property (nonatomic,assign) CGRect addresssF;
@property (nonatomic,assign) CGRect bgViewF;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end

@interface YNDetailsManMsgCell : UICollectionViewCell

@property (nonatomic,strong) YNManMsgCellFrame * cellFrame;

@end

@interface YNOrderMsgCellFrame : NSObject

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect codeLF;
@property (nonatomic,assign) CGRect codeRF;
@property (nonatomic,assign) CGRect buyTimeLF;
@property (nonatomic,assign) CGRect buyTimeRF;
@property (nonatomic,assign) CGRect payTimeLF;
@property (nonatomic,assign) CGRect payTimeRF;
@property (nonatomic,assign) CGRect addresssLF;
@property (nonatomic,assign) CGRect addresssRF;
@property (nonatomic,assign) CGRect statusLF;
@property (nonatomic,assign) CGRect statusRF;
@property (nonatomic,assign) CGRect bgViewF;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end
@interface YNDetailsOrderMsgCell : UICollectionViewCell

@property (nonatomic,strong) YNOrderMsgCellFrame * cellFrame;

@end

@interface YNCountdownMsgCell : UICollectionViewCell

@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) void (^viewDidDisappearStopTimerBlock)();

@property (nonatomic,copy) void (^buttonNoClickStopTimerBlock)();

@end
@interface YNOrderDetailsHeaderView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary *dict;

@end
@interface YNOrderDetailsFooterView : UICollectionReusableView

@property (nonatomic,strong) NSString *allPrice;

@end
