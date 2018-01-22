//
//  PhotoAlertView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlertView : UIView

+ (void)showInView:(UIView*)view takePhoto:(ActionBlock)block1 getPhotos:(ActionBlock)block2 ;

@end
