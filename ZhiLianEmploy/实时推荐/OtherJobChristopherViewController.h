//
//  OtherJobChristopherViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-4.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CompanyEntry.h"
typedef void(^ popValueForSelectResultBlock) (id company,BOOL isOtherJOb);
@protocol OtherJobChristopherViewControllerDelegate;
@interface OtherJobChristopherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableView;
    BOOL _isOtherJOb;
    
    popValueForSelectResultBlock popValue;
    NSMutableArray *_jobsArray;
}
@property(nonatomic,retain)id<OtherJobChristopherViewControllerDelegate> delegate;
@property(nonatomic,assign)BOOL isOtherJOb;
@property(nonatomic,retain)NSMutableArray *jobsArray;
-(void)setPopValue:(popValueForSelectResultBlock)block;

@end
@protocol OtherJobChristopherViewControllerDelegate <NSObject>

-(void)OtherJobChristopherViewController:(OtherJobChristopherViewController *)otherjob withcompany:(CompanyEntry *)aCompany withIsOtherJob:(BOOL)isList;


@end
