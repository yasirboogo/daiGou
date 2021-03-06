//
//  YNMineCollectTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNMineCollectTableView : UITableView

@property (nonatomic,strong) NSMutableArray<NSNumber*> * selectArrayM;

@property (nonatomic,strong) NSMutableArray * dataArrayM;
/** 是否编辑 */
@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,copy) void(^didSelectMineCollectCellBlock)(NSString*);

@end

@interface YNMineCollectCell : UITableViewCell
/** 勾选回调 */
@property (nonatomic,copy) void(^didSelectedButtonClickBlock)(BOOL);
/** 是否勾选 */
@property (nonatomic,assign) BOOL isSelected;
/** 是否编辑 */
@property (nonatomic,assign) BOOL isEdit;
/** 是否无效 */
@property (nonatomic,assign) BOOL isInvalid;
/** 数据模型 */
@property (nonatomic,weak) NSDictionary *cellDict;
/** 左边图片 */
@property (nonatomic,weak) UIImageView * leftImgView;
/** 标题 */
@property (nonatomic,weak) UILabel * titleLabel;
/** 版本号 */
@property (nonatomic,weak) UILabel * versionLabel;
/** 价格 */
@property (nonatomic,weak) UILabel * priceLabel;

@end
