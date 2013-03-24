//
//  SearchsamejobViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-4.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClassUseOften.h"
@interface SearchsamejobViewController : UITableViewController
{
    MyClassUseOften *myClass;
}
@property(nonatomic,retain)NSMutableArray *Source;
@property(nonatomic,retain)NSString *utiket;
@end
