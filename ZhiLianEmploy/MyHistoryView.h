//
//  MyHistoryView.h
//  ZhiLianLQX
//
//  Created by tony J on 13-2-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHistoryView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *HistoryTableView;
@end
