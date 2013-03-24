//
//  MoreDetailConditionViewController.h
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreDetailConditionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * chooseCityArr;
    NSMutableArray * chooseCityDataArr;
    NSMutableArray * chooseCityBack;

}
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)NSIndexPath * indexpath;
@property(nonatomic,retain)NSString * identifier;
@property(nonatomic,retain)NSString * identifier1;

@end
