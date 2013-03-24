//
//  SecondPushViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondPushViewController : UIViewController

@property(nonatomic,retain)NSMutableArray *textArr;
@property(nonatomic,retain)NSIndexPath *indexpaths;


@property(nonatomic,retain)NSIndexPath *EndIndexPath;
@property(nonatomic,retain)UITextView *EndtextView;
@property(nonatomic,retain)NSMutableArray *IdPushArr;
@property(nonatomic,retain)NSMutableDictionary *IdPushDic;
@property(nonatomic,retain)NSMutableArray *titleArr;
@property(nonatomic,retain)NSMutableArray *IDdicArr;

@property(nonatomic,retain)NSMutableString *startdate;


@end
