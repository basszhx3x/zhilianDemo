//
//  PublishTimeViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PublishTimeViewControllerBlock)(NSString *str,NSString *ID);
@interface PublishTimeViewController : UITableViewController

{
    PublishTimeViewControllerBlock strBlock;
}

@property(nonatomic,retain) NSMutableArray *timearr;


-(void)setStrBlock:(PublishTimeViewControllerBlock)block;

@end
