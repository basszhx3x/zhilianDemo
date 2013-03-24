//
//  SalaryPushViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaryQuerylist.h"
@protocol SalaryPushViewControllerDelegate;
typedef enum
{
    citys = 0,
    industry,//行业
    corpproperty,//企业性质
    jobcat,//职位类别
    joblevel,//职位级别
    education
}indextargets;
@interface SalaryPushViewController : UITableViewController

{
    NSMutableDictionary *_sourceDataDictionary;

}
@property(nonatomic,retain)NSMutableDictionary *sourceDataDictionary;
@property(nonatomic,retain)SalaryQuerylist *salaryQuelist;
@property(nonatomic,retain)NSString *indexTarget;
@property(nonatomic,assign)indextargets index;
@property(nonatomic,retain)NSMutableArray *sourcData;
@property(nonatomic,retain)NSIndexPath *aindexPath;
@property(nonatomic,assign)id<SalaryPushViewControllerDelegate> delegate;

@end
@protocol SalaryPushViewControllerDelegate <NSObject>
-(void)SalaryPushViewController:(SalaryPushViewController *)aViewCOntroller withTargetString:(NSString *)aStr withIndexPath:(NSIndexPath *)aIndexPath;
-(void)SalaryPushViewController:(SalaryPushViewController *)aViewCOntroller withIdIndex:(NSString *)aID withINdexPath:(NSIndexPath *)aIndex;

@end