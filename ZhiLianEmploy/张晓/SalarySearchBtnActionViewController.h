//
//  SalarySearchBtnActionViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawImageView.h"
#import "SearchBtnMoreViewController.h"
#import "SalaryPushViewController.h"
@interface SalarySearchBtnActionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SearchBtnMoreViewControllerDelegate>

{
    NSMutableArray * _pointArray;
    BOOL isCompareQuery;
    DrawImageView *drawImageView;
    UIView *viewForLine;
    NSIndexPath *tmpIndexPath;
    UILabel *sixlable;
    BOOL isEditStatus;
}

@property(nonatomic,retain)NSMutableArray *pointArray;
@property(nonatomic,retain)NSMutableArray *comparePointArray;
@property(nonatomic,retain)NSIndexPath *secondIndexPath;
@property(nonatomic,retain)UITableView *maintableView;
@property(nonatomic,assign)BOOL secondRowChangeState;
@property(nonatomic,retain)NSMutableDictionary *secondRowSource;

@end
