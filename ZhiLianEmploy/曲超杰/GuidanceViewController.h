//
//  GuidanceViewController.h
//  ZhiLianLQX
//
//  Created by Ibokan on 13-2-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidanceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)UITableView *PageTableView;
@property(nonatomic,retain)NSMutableArray *NameArr;
@property(nonatomic,retain)NSMutableArray *TitleArr;
@property(nonatomic,retain)NSMutableArray *contentArr;
@property(nonatomic,retain)NSMutableArray *IDArray;
@property(nonatomic,retain)NSMutableArray *IDTitSectionArr;
@property(nonatomic,retain)UIButton *butn;
@property(nonatomic,retain)NSMutableDictionary *IDdicText;
@property(nonatomic,retain)NSIndexPath *PushSection;
@property(nonatomic,retain)UIView *PageView;
@property(nonatomic,retain)NSMutableArray *IDChannelArr;


@end
