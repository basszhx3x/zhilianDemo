//
//  ResumeView.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ResumeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ResumeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.resumeName=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
//        self.resumeName.text=@"软件工程师1年 东营";
        self.resumeName.textAlignment=NSTextAlignmentCenter;
        self.resumeName.backgroundColor=[UIColor clearColor];
        [self addSubview:self.resumeName];
        
        UILabel * base=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 60)];
        base.userInteractionEnabled=YES;
        base.layer.cornerRadius=5;
        [self addSubview:base];
        [base release];
        
        //浏览人数
        self.scanNum=[[[UIButton alloc] initWithFrame:CGRectMake(0, 7, 110, 30)] autorelease];
        self.scanNum.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
        self.scanNum.userInteractionEnabled=YES;
//        self.scanNum.textAlignment=NSTextAlignmentCenter;
        [base addSubview:self.scanNum];
        
        //
        UILabel * scan=[[UILabel alloc] initWithFrame:CGRectMake(0, 30, 110, 30)];
        scan.text=@"浏览";
        scan.font=[UIFont fontWithName:@"Arial" size:14];
        scan.userInteractionEnabled=YES;
        scan.textAlignment=NSTextAlignmentCenter;
        scan.textColor=[UIColor grayColor];
        [base addSubview:scan];
        [scan release];
        
        UIView * gapLine1=[[UIView alloc] initWithFrame:CGRectMake(110, 0, 1, 60)];
        gapLine1.backgroundColor=[UIColor grayColor];
        gapLine1.userInteractionEnabled=YES;
        [base addSubview:gapLine1];
        [gapLine1 release];
        //
        self.refresh=[UIButton buttonWithType:UIButtonTypeCustom];
        self.refresh.frame=CGRectMake(138, 10, 25, 25);
        [self.refresh setBackgroundImage:[UIImage imageNamed:@"reresh_resume_button.png"] forState:0];
        [base addSubview:self.refresh];
        
        //
        UILabel *reSet=[[UILabel alloc] initWithFrame:CGRectMake(111, 30, 80, 30)];
        reSet.text=@"刷新";
        reSet.userInteractionEnabled=YES;
        reSet.font=[UIFont fontWithName:@"Arial" size:14];
        reSet.textAlignment=NSTextAlignmentCenter;
        reSet.backgroundColor=[UIColor clearColor];
        reSet.textColor=[UIColor grayColor];
        [base addSubview:reSet];
        [reSet release];
        
        UIView * gapLine2=[[UIView alloc] initWithFrame:CGRectMake(190, 0, 1, 60)];
        gapLine2.backgroundColor=[UIColor grayColor];
        gapLine2.userInteractionEnabled=YES;
        [base addSubview:gapLine2];
        [gapLine2 release];
        
        //
        self.setResume=[UIButton buttonWithType:UIButtonTypeCustom];
        self.setResume.frame=CGRectMake(233, 10, 25, 25);
        self.setResume.userInteractionEnabled=YES;
        self.setResume.backgroundColor=[UIColor whiteColor];
        [self.setResume setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
        [base addSubview:self.setResume];
        
        UILabel *setDefalut=[[UILabel alloc] initWithFrame:CGRectMake(190, 30, 110, 30)];
        setDefalut.text=@"设置默认简历";
        setDefalut.userInteractionEnabled=YES;
        setDefalut.font=[UIFont fontWithName:@"Arial" size:14];
        setDefalut.backgroundColor=[UIColor clearColor];
        setDefalut.textAlignment=NSTextAlignmentCenter;
        setDefalut.textColor=[UIColor grayColor];
        [base addSubview:setDefalut];
        [setDefalut release];
        
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
