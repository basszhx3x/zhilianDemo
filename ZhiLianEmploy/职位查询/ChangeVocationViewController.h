//
//  ChangeVocationViewController.h
//  ZhiLianLQX
//
//  Created by tony J on 13-2-20.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeVocationViewControllerBlock)(NSString *str);
@interface ChangeVocationViewController : UITableViewController
{
    ChangeVocationViewControllerBlock strBlock;
}
@property(nonatomic,retain)NSMutableArray *arr;

-(void)setStrBlock:(ChangeVocationViewControllerBlock)block;

@end
