//
//  CreatJobSearchorViewController.h
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-24.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDetailConditionViewController.h"

@interface CreatJobSearchorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,transferSearchJobConditionDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray * titleArr1;
    NSMutableArray * titleArr2;
    NSMutableArray * subTitleArr;
    NSMutableArray * moreArr;
    NSDictionary * dic;
    UIButton * save;
    UIView * callBackView;
    UIView * moreView;
    UIView * salaryView;
    UIPickerView * salaryPick;
    NSMutableArray * salaryArr;//月薪内容
    NSMutableArray * salaryDataArr;
}
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)UIScrollView * myScrollView;
@property(nonatomic,retain)NSMutableDictionary * ADictionary;
@property(nonatomic,retain)NSMutableArray * backSubTitle;
@property(nonatomic,retain)UIActionSheet * myActionSheet;

@end
