//
//  WorkEXPViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WorkEXPViewControllerBlock)(NSString *str,NSIndexPath *indes);
@interface WorkEXPViewController : UITableViewController
{
    WorkEXPViewControllerBlock strBlock;
}

@property(nonatomic,retain) NSMutableArray *WorkExpArr;
@property(nonatomic,retain) NSIndexPath *indes;

-(void)setStrBlock:(WorkEXPViewControllerBlock)block;
@end
