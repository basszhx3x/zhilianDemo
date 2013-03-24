//
//  InstanceRecommendViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "MyClassUseOften.h"
#import <UIKit/UIKit.h>
#import "Positionlist.h"
@interface InstanceRecommendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isFirstShow;
    NSString * utiket;
    MyClassUseOften *myClass;
    UITableView *mainTabelView;
    Positionlist *positionlistSource;
    NSMutableArray *_applyjob_jobtitles;
    NSMutableArray *_selectCellArray;
    NSMutableDictionary *resultDictionary;
    BOOL isDsAppearStatus;
    NSMutableArray *sectionArray;
}
@property(nonatomic,retain)NSMutableArray *positionlist;
@property(nonatomic,retain)NSMutableArray *applyjob_jobtitles;
@property(nonatomic,retain)NSMutableArray *selectCellArray;
@property(nonatomic,retain)NSMutableArray *selectCell;
@property(nonatomic,retain)NSMutableDictionary *sourceDictionary;
@end
