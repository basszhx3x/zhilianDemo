//
//  LasteastJobViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LasteastJobViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIPickerView * setRangeView;
    NSMutableArray * setRangeArr;
    UIButton * setRangeBtn;
    NSMutableArray * setRangeTitle;
    NSMutableArray * chooseJob;
 

}
@property(nonatomic,retain)NSString * titleName;
@property(nonatomic,retain)UIActionSheet * myActionSheet;
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)NSMutableArray * dataArr;


@end
