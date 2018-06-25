//
//  AppDelegate.m
//  KWLaunchView
//
//  Created by WEISON on 17/8/4.
//  Copyright © 2017年 siso. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "KWLaunchView.h"
#import "KWAdModel.h"
#import "KWLaunchViewManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self addMainWindow];
    [self addADLaunchController];
    return YES;
}

- (void)addMainWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}
    
    //加载广告
- (void)addADLaunchController {
    KWAdModel * adModel=[[KWAdModel alloc]init];
    //静态图
    // adModel.launchUrl = @"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg";
    //动态图
    //adModel.launchUrl = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=408862874,416826962&fm=23&gp=0.jpg";
    adModel.launchUrl = @"123456.gif";
    //点击跳转链接
    adModel.adDetailUrl = @"http://www.baidu.com";
    KWLaunchViewManager *launchController = [KWLaunchViewManager launchViewManger];
    launchController.adModel = adModel;
    [launchController showView:self.window.rootViewController.view];
    launchController.tapClick =^{
        NSLog(@"点击动画");
    };

}
    
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
