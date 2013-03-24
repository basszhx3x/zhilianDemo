//
//  PushJobViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PushJobViewControllerDelegate;
@interface PushJobViewController : UITableViewController

{
    id<PushJobViewControllerDelegate> _delegate;
}

@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,retain)NSMutableArray *PushArr;
@property(nonatomic,assign)id<PushJobViewControllerDelegate> delegate;

@end
@protocol PushJobViewControllerDelegate <NSObject>

-(void)pushJobViewController:(PushJobViewController *)Pvc
              PushJobViewStr:(NSString *)str;

@end