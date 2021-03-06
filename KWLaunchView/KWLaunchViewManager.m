//
//  KWLaunchViewManager.m
//  KWLaunchView
//
//  Created by WEISON on 17/8/4.
//  Copyright © 2017年 siso. All rights reserved.
//

#import "KWLaunchViewManager.h"
#import "KWLaunchView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+KWLaunchImage.h"
#import "KWAdModel.h"
#import "FLAnimatedImageView+WebCache.h"
#import "FLAnimatedImage.h"

@interface KWLaunchViewManager ()
@property (nonatomic, weak) KWLaunchView *launchView;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation KWLaunchViewManager
    
+(instancetype)launchViewManger {
    return [[[ self class]alloc]init];
}
    
-(void)showView:(UIView *)view {
    self.frame = view.bounds;
    [view addSubview:self];
    [self addADLaunchView];
    [self loadData];

}
    
- (void)addADLaunchView {
    KWLaunchView *adLaunchView = [[KWLaunchView alloc]init];
    adLaunchView.skipBtn.hidden = YES;
    //有两种加载启动页的设置方式 如果使用LaunchScreen.storyboard来设置启动页bIsLaunchImage 设置成NO  如果是使用LaunchImage来设置  bIsLaunchImage 设置成YES
    adLaunchView.launchImageView.image = [UIImage getLaunchImageWithbIsLaunchImage:YES];
    adLaunchView.frame = self.bounds;
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:adLaunchView];
    _launchView = adLaunchView;
}
    
    //加载数据
- (void)loadData {
    if ( _adModel.launchUrl && _adModel.launchUrl.length>0) {
        [self showADImageWithURL:[NSURL URLWithString:_adModel.launchUrl]];
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAdController)];
        [_launchView addGestureRecognizer:tap];
    }else{
        [self dismissController];
    }
}
    
    //设置广告图片
- (void)showADImageWithURL:(NSURL *)url {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123456" ofType:@"gif"];
    
    NSData*  data=[NSData dataWithContentsOfFile:filePath];
    _launchView.adImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    [self scheduledGCDTimer];
    
    /*
     __weak typeof(self) weakSelf = self;
    [_launchView.adImageView  sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 启动倒计时
        [weakSelf scheduledGCDTimer];
    }];
     */
}
    
    //跳过倒计时
- (void)showSkipBtnTitleTime:(int)timeLeave {
    NSString *timeLeaveStr = [NSString stringWithFormat:@"跳过 %ds",timeLeave];
    [_launchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _launchView.skipBtn.hidden = NO;
}
    
- (void)scheduledGCDTimer {
    [self cancleGCDTimer];
    __block int timeLeave = DURATION; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [self dismissController];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面
                //[weakSelf showSkipBtnTitleTime:curTimeLeave];
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}
    
- (void)cancleGCDTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
    
#pragma mark - action
    
- (void)skipADAction {
    [self dismissController];
}
    
- (void)dismissController {
    [self cancleGCDTimer];
    //消失动画
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩放修改处
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
    
-(void)pushAdController {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        if (self.tapClick) {
            self.tapClick();
        }
    });
}
    
- (void)dealloc {
    [self cancleGCDTimer];
}
    
-(void)show {
    [self addADLaunchView];
    [self loadData];
}

@end
