//
//  JobInfoViewController.h
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSIndexPath * _indexPath;
    BOOL wheatherDelete;
    UIPickerView * takeDaysView;
    NSMutableArray * takeDaysArr;
    NSMutableArray * wheatherFirstPickArr;
    NSMutableArray * getLastestTransferArr;
    UIButton * edit;
    NSMutableArray * chooseJobBack;
    UIView * load;
    

}
@property(nonatomic,retain)NSIndexPath * indexPath;
@property(nonatomic,retain)NSString * search;
@property(nonatomic,retain)NSMutableArray * searchArr;
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)UIActionSheet * myActionSheet;
@property(nonatomic,retain)NSString * takeDayasStr;
@property(nonatomic,retain)NSMutableArray * jobApplyArr;
-(id)initWithIndexPath:(NSIndexPath *)aIndexPath;

@end
