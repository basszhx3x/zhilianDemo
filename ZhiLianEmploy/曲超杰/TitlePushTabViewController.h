//
//  TitlePushTabViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-23.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitlePushTabViewController : UITableViewController

@property(nonatomic,retain)NSMutableArray *countArr;
@property(nonatomic,retain)NSMutableArray *IDTitleArr;
@property(nonatomic,retain)NSMutableArray *IDChannelPushArr;
@property(nonatomic,retain)NSMutableArray *IDChannelPushTitleArr;
@property(nonatomic,retain)NSIndexPath *section;
@property(nonatomic,assign)NSInteger pushTag;
@property(nonatomic,retain)NSString *NameText;
@property(nonatomic,retain)NSMutableArray *IDTextArr;



@end
