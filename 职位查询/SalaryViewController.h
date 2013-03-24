//
//  SalaryViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopSalarDelegate;
@interface SalaryViewController : UITableViewController


{
    id<PopSalarDelegate> _delegate;
}
@property(nonatomic,retain) NSMutableArray *SalaryArr;
@property(nonatomic,assign)id<PopSalarDelegate> delegate;

@end

@protocol PopSalarDelegate <NSObject>
    
-(void)SalaryViewController:(SalaryViewController *)svc
                    string:(NSString *)str;

@end
