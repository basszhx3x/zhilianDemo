//
//  JobMessageViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-3.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobMessageViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *  blackView;
    NSArray * strs;

}


@property(nonatomic,retain)UIScrollView *CompanyMesTextView;
@property(nonatomic,retain)UIScrollView *JobMesTextView;
@property(nonatomic,retain)NSMutableDictionary *JobNumDic;
@property(nonatomic,retain)UIImage *imageColor;
@property(nonatomic,retain)NSMutableArray *AllArr;
@property(nonatomic,retain)NSMutableArray *ComanyAllArr;
@property(nonatomic,retain)UIView *cView;


//-(void)setImageColor:(UIImage *)image forSegmentAtIndex:(NSUInteger)index forState:(UIControlState)state;


@end
