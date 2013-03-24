//
//  SalarySearchViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryPushViewController.h"
#import "SalaryQuerylist.h"
@interface SalarySearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SalaryPushViewControllerDelegate>

@property(nonatomic,retain)UITextField *textField1;

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableDictionary *sourceDataDic;
@property(nonatomic,retain)SalaryQuerylist *querylist;

@end
