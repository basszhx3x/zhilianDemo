//
//  scanResumeCompanyInfoViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-1.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scanResumeCompanyInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)NSString * pageSize;
@property(nonatomic,retain)NSString * search;
@property(nonatomic,retain)NSMutableArray * dataArr;

@end
