//
//  ChangeJobViewController.h
//  ZhiLianLQX
//
//  Created by tony J on 13-2-20.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushJobViewController.h"
@interface ChangeJobViewController : UITableViewController<PushJobViewControllerDelegate>

@property(nonatomic,retain) NSMutableArray *arr;
@property(nonatomic,assign) id<PushJobViewControllerDelegate> delegate1;
@end

@protocol ChangeJobViewControllerDelegate <NSObject>

-(void)ChangeJobViewController:(ChangeJobViewController *)chvc
                  ChangeJobStr:(NSString *)str;

@end