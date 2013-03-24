//
//  CompsizeViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CompsizeDelegate;
@interface CompsizeViewController : UITableViewController
{
    id<CompsizeDelegate> _delegate;
}
@property(nonatomic,retain) NSMutableArray *compsizeArr;
@property(nonatomic,assign)id<CompsizeDelegate> delegate;
@end
@protocol CompsizeDelegate <NSObject>

-(void)CompsizeViewController:(CompsizeViewController *)cVc
               compsizeArrStr:(NSString *)str;

@end