//
//  KWLaunchViewManager.h
//  KWLaunchView
//
//  Created by WEISON on 17/8/4.
//  Copyright © 2017年 siso. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KWAdModel.h"
//广告倒计时间 单位：秒
#define DURATION 3
@class KWAdModel;

@interface KWLaunchViewManager : UIView
//广告模型
@property (nonatomic , strong) KWAdModel  *adModel;
//点击广告图回调
@property (nonatomic , copy) void(^tapClick) ();
//创建一个对象
+(instancetype)launchViewManger;
//展示对象
-(void)showView:(UIView *)view;
@end
