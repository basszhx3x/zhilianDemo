//
//  SearchBtnMoreViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryQuerylist.h"
@protocol SearchBtnMoreViewControllerDelegate;
@interface SearchBtnMoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSString *compareIndexString;
@property(nonatomic,retain)UITableView *mainTableView;
@property(nonatomic,retain)NSIndexPath *selectIndexPath;
@property(nonatomic,retain) NSArray *cellLableStr;
@property(nonatomic,retain)SalaryQuerylist *queryList;
@property(nonatomic,assign)id<SearchBtnMoreViewControllerDelegate> delegate;
@end
@protocol SearchBtnMoreViewControllerDelegate <NSObject>

-(void)SearchBtnMoreViewController:(SearchBtnMoreViewController *)aViewController withSelectString:(NSString *)aStr withIndexPath:(NSIndexPath *)aPath withIndexPathRow:(int) aInt withIsEdit:(BOOL)aBool;
-(void)SearchBtnMoreViewController:(SearchBtnMoreViewController *)aViewController withCompareIndexString:(NSString *)aStr withIndexPath:(NSIndexPath *)aPAth withIDString:(NSString *)aId;

@end