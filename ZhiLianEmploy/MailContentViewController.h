//
//  MailContentViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailContentViewController : UIViewController
@property(nonatomic,retain)NSString * email_number;
@property(nonatomic,retain)NSString * Company_name;
@property(nonatomic,retain)NSString * Is_read;
@property(nonatomic,retain)NSString * uticket;
@property(nonatomic,retain)NSMutableArray * dataArr;

@end
