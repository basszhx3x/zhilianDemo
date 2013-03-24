//
//  LoginOutViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginOutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * imgArr;
    NSArray * titleArr;

}
@property(nonatomic,retain)UITableView * myTableView;

@end
