//
//  YNNewsDetailHeaderView.h
//  AgentSsales
//
//  Created by innofive on 17/1/23.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewsDetailHeaderView : UIScrollView

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) NSString *commentNum;

@property (nonatomic,copy) void(^htmlDidLoadFinish)();

@property (nonatomic,copy) void(^didSelectLikeButtonBlock)(BOOL);

@end

@interface YNWebHeaderView : UIView
@property (nonatomic,strong) NSDictionary *dict;
@end

@interface YNWebFooterView : UIView

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,strong) NSString *commentNum;

@property (nonatomic,copy) void(^didSelectLikeButtonBlock)(BOOL);
@end
