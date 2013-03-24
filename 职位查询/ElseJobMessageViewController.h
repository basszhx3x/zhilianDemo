//
//  ElseJobMessageViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElseJobMessageViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)UIScrollView *CompanyMesTextView;
@property(nonatomic,retain)UIScrollView *JobMesTextView;
@property(nonatomic,retain)NSMutableDictionary *JobNumDic;
@property(nonatomic,retain)UIImage *imageColor;
@property(nonatomic,retain)NSMutableArray *AllArr;
@property(nonatomic,retain)NSMutableArray *ComanyAllArr;
@property(nonatomic,retain)UIView *cView;


@end
