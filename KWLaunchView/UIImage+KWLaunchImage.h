//
//  UIImage+KWLaunchImage.h
//  KWLaunchView
//
//  Created by WEISON on 17/8/4.
//  Copyright © 2017年 siso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KWLaunchImage)
    //有两种加载启动页的设置方式 如果使用LaunchScreen.storyboard来设置启动页bIsLaunchImage 设置成NO  如果是使用LaunchImage来设置  bIsLaunchImage 设置成YES
+ (UIImage *)getLaunchImageWithbIsLaunchImage:(BOOL)bIsLaunchImage;
@end
