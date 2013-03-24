//
//  DawnCusTabBarViewController.h
//  selfCustom
//
//  Created by Ibokan on 12-12-25.
//  Copyright (c) 2012年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusTabBarViewController : UITabBarController
{
    UIButton *_shareButton;

}
@property(nonatomic,retain)UIView *barBView ;
@property(nonatomic,retain)UIButton *shareButton;

@end
