//
//  QuickSearchViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
//#import <<#header#>>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "PublishTimeViewController.h"
#import "WorkEXPViewController.h"
#import "EducationViewController.h"
#import "CompTypeViewController.h"
#import "CompsizeViewController.h"
#import "SalaryViewController.h"
#import "PicViewController.h"
#import "PushJobViewController.h"
#import "ChangeCell.h"



@interface QuickSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,
PopSalarDelegate,CompsizeDelegate,CompTypeDelegate,EducationDelegate,PushJobViewControllerDelegate,CLLocationManagerDelegate>

@property(nonatomic,retain)NSMutableString *Popstr;
@property(nonatomic,retain)UITableView *PageTableView;
@property(nonatomic,retain)UIButton *butn;
@property(nonatomic,retain)NSMutableArray *LinerArray;
@property(nonatomic,retain)NSMutableArray *SecLinerArray;
@property(nonatomic,retain)NSMutableDictionary *PageDic;
@property(nonatomic,retain)NSMutableArray *TitelArray;
@property(nonatomic,retain)NSMutableArray *CellArray;
@property(nonatomic,retain)NSMutableArray * subTitleArray;
@property(nonatomic,retain)NSMutableArray * subCellArray;
@property(nonatomic,retain)NSMutableArray * subMinArray;
@property(nonatomic,retain)NSMutableArray *CellArrayEnd;
@property(nonatomic,retain)NSMutableArray *CellArrayMid;
@property(nonatomic,retain)NSIndexPath *indexpaths;
@property(nonatomic,retain)NSString *SalaryStr;
@property(nonatomic,retain)NSString *ComSizeStr;
@property(nonatomic,retain)NSString *WorkEXPStr;
@property(nonatomic,retain)NSIndexPath *indes;
@property(nonatomic,retain)ChangeCell *changeCells;
@property(nonatomic,retain)NSMutableDictionary *SearchDic;
@property(nonatomic,retain)CLLocationManager *loationManage;


//-(void)CellAction;
@end
