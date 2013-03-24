//
//  EducationViewController.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EducationDelegate;
@interface EducationViewController : UITableViewController
{
    id<EducationDelegate> _delegate;
}
@property(nonatomic,retain) NSMutableArray *educationArr;
@property(nonatomic,assign)id<EducationDelegate> delegate;
@end
@protocol EducationDelegate <NSObject>

-(void)EducationViewController:(EducationViewController *)evc
                  educationStr:(NSString *)str
                   educationID:(NSString *)ID;

@end