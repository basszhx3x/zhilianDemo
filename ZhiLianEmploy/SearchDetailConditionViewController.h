//
//  SearchDetailConditionViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol transferSearchJobConditionDelegate;

@interface SearchDetailConditionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * chooseJobArr;
    NSMutableArray * chooseJobDataArr;
    
    NSMutableArray * chooseJobBack;
    NSMutableArray * chooseArea;
    NSMutableArray * choosePosition;

}
@property(nonatomic,retain)NSIndexPath * indexpath;
@property(nonatomic,retain)UITableView * myTableView;
@property(nonatomic,retain)UIScrollView * myScrollView;
@property(nonatomic,assign)id<transferSearchJobConditionDelegate>delegate;
@property(nonatomic,retain)NSMutableDictionary * indexPathDic;



@end
@protocol transferSearchJobConditionDelegate <NSObject>

-(void)transferSearchJobCondition:(SearchDetailConditionViewController *)aViewController withCondition:(NSString *)aStr withIndexpath:(NSIndexPath *)indexpath withNsdictionary:(NSMutableDictionary *)dictionary;


@end
