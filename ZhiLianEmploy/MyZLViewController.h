//
//  MyZLViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyZLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    UITextField * post;
    UITextField * secret;
    UIButton * rightButton;
    
    NSArray * imgArr;
    NSArray * titleArr;
    NSMutableArray * infoArr;
    
    NSArray * subViews1;
    NSArray * subViews2;
    
    //
    UIPageControl * resumePageControl;
    UIScrollView * resumeScrollView;
    
    UIView * alarmView;
    UIView * alarmView1;
    
    //用于设置简历的判断按钮
    UIButton * wheatherBtn;
    NSMutableArray * resumeBtnTagArr;//存储简历btn tag
//    UIButton * wheatherBtn1;
    
}
@property(nonatomic,retain)UIImageView *MyImageView;
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)NSString * search;
@property(nonatomic,retain)NSMutableArray * resultArr;
@end
