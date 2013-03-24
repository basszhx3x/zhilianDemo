//
//  CompTypeViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CompTypeDelegate;
@interface CompTypeViewController : UITableViewController

{
    id<CompTypeDelegate> _delegate;
}
@property(nonatomic,retain) NSMutableArray *comptypeArr;
@property(nonatomic,assign) id<CompTypeDelegate> delegate;

@end


@protocol CompTypeDelegate <NSObject>

-(void)CompTypeViewController:(CompTypeViewController *)ctvc
                  CompTypeStr:(NSString *)str;

@end