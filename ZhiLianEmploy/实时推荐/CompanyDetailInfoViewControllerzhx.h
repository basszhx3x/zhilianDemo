//
//  CompanyDetailInfoViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClassUseOften.h"
#import "CompanyEntry.h"
#import "OtherJobChristopherViewController.h"
@interface CompanyDetailInfoViewControllerzhx : UIViewController<OtherJobChristopherViewControllerDelegate>
{
    UIButton * jobIntroduce;
    UIButton * companyIntroduce;
    
    UIScrollView * scrollView1;
    UIScrollView * scrollView2;
    
    CompanyEntry *_companyDetail;
    NSString *_Job_number;
    MyClassUseOften *myclass;
    
    BOOL isOtherJob;
    //职位介绍界面
    UILabel * jobName;//职位名称
    UILabel * salary;//月薪
    UILabel * address;//地点
    UILabel * exp;//经验
    UILabel * perNum;//人数
    UILabel * jobDetailInfo;//职位描述
    
    //公司介绍界面
    UILabel * companyName;//公司名称
    UILabel * kind;//类别
    UILabel * scale;//规模
    UILabel * industry;//行业
    UILabel * companyAddress;//地址
    UILabel * companyDetailInfo;//公司介绍
    
    UIView * aView;
    

}
@property(nonatomic,retain)NSString *uiuticket;
@property(nonatomic,retain)NSMutableArray *jobListArr;
@property(nonatomic,retain)CompanyEntry *companyDetail;
@property(nonatomic,retain)NSString *Job_number;
//@property(nonatomic,retain)MyClassUseOften *myclass;
@property(nonatomic,retain)NSString * identifier;

@end
