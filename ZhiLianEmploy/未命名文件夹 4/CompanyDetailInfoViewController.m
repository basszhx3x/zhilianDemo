//
//  CompanyDetailInfoViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "CompanyDetailInfoViewController.h"
#import "RequestData.h"
#import "ZhiLianManager.h"
#import "NSString+removeSaceAndEnter.h"
#import "jobIntroduceAndCompanyIntroduceEntity.h"
@interface CompanyDetailInfoViewController ()

@end

@implementation CompanyDetailInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArr=[[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}
-(void)dealloc
{
    [_dataArr release];
    [super dealloc];

}

-(void)loadView
{
    
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 50, 30);
    [back setTitle:@"返回" forState:0];
    [back setTitleColor:[UIColor whiteColor] forState:0];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:back];
    
    
    UIButton * backFirstPage=[UIButton buttonWithType:UIButtonTypeCustom];
    backFirstPage.frame=CGRectMake(0, 0, 70, 30);
    [backFirstPage setTitle:@"返回首页" forState:0];
    [backFirstPage setTitleColor:[UIColor whiteColor] forState:0];
    backFirstPage.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [backFirstPage setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [backFirstPage setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [backFirstPage addTarget:self action:@selector(backFirstPage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backFirstPage];
    
    self.title=@"职位信息";
    
    //写界面
    //职位介绍
    jobIntroduce=[UIButton buttonWithType:UIButtonTypeCustom];
    [jobIntroduce setBackgroundImage:[UIImage imageNamed:@"jobDescSelected.png"] forState:0];
    jobIntroduce.frame=CGRectMake(0, 0, 160, 30);
    [jobIntroduce addTarget:self action:@selector(jobIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jobIntroduce];
    
    //公司介绍
    companyIntroduce=[UIButton buttonWithType:UIButtonTypeCustom];
    [companyIntroduce setBackgroundImage:[UIImage imageNamed:@"companyDescNormal.png"] forState:0];
    companyIntroduce.frame=CGRectMake(160, 0, 160, 30);
    [companyIntroduce addTarget:self action:@selector(companyIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:companyIntroduce];
    
    //两种scrollView；
    
    //scrollView1
    scrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 480-20-44-49-30)];
    scrollView1.backgroundColor=[UIColor whiteColor];
    scrollView1.contentSize=CGSizeMake(0, 600);
    [self.view addSubview:scrollView1];
    //搭建scrollView1的UI
    jobName=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    jobName.textColor=[UIColor orangeColor];
    jobName.textAlignment=NSTextAlignmentLeft;
    //设置自动换行
    jobName.lineBreakMode=NSLineBreakByWordWrapping;
    jobName.numberOfLines=10;
//    jobName.text=@"工程署哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈啊哈哈哈哈哈";
    [scrollView1 addSubview:jobName];
    [jobName release];
    
    UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    label1.text=@"月薪:";
    [scrollView1 addSubview:label1];
    [label1 release];
    
    salary=[[UILabel alloc] initWithFrame:CGRectMake(50, 40, 150, 20)];
    [scrollView1 addSubview:salary];
    [salary release];
    
    UILabel * label5=[[UILabel alloc] initWithFrame:CGRectMake(200, 40, 40, 20)];
    label5.text=@"元/月";
    [scrollView1 addSubview:label5];
    [label5 release];
    
    
    
    UILabel * label2=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
    label2.text=@"地点:";
    [scrollView1 addSubview:label2];
    [label2 release];
    
    address=[[UILabel alloc] initWithFrame:CGRectMake(50, 60, 200, 20)];
    [scrollView1 addSubview:address];
    [address release];
    
    UILabel * label3=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
    label3.text=@"经验:";
    [scrollView1 addSubview:label3];
    [label3 release];
    exp=[[UILabel alloc] initWithFrame:CGRectMake(50, 80, 100, 20)];
    [scrollView1 addSubview:exp];
    [exp release];
    
    UILabel * label4=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 40, 20)];
    label4.text=@"人数:";
    [scrollView1 addSubview:label4];
    [label4 release];
    
    perNum=[[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 20)];
    [scrollView1 addSubview:perNum];
    [perNum release];
    
    UIView * gapLine=[[UIView alloc] initWithFrame:CGRectMake(0, 130, 320, 1)];
    gapLine.backgroundColor=[UIColor grayColor];
    [scrollView1 addSubview:gapLine];
    [gapLine release];
    
    jobDetailInfo=[[UILabel alloc] initWithFrame:CGRectMake(0, 131, 320, 600-131)];
    jobDetailInfo.lineBreakMode=NSLineBreakByWordWrapping;
    jobDetailInfo.numberOfLines=2000;
    [scrollView1 addSubview:jobDetailInfo];
    
    
    scrollView2=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 480-20-44-49-30)];
    scrollView2.backgroundColor=[UIColor whiteColor];
    scrollView2.contentSize=CGSizeMake(0, 600);
    [self.view addSubview:scrollView2];
    //搭建scrollView2的UI
    companyName=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    companyName.textColor=[UIColor orangeColor];
    companyName.textAlignment=NSTextAlignmentLeft;
    //设置自动换行
    companyName.lineBreakMode=NSLineBreakByWordWrapping;
    companyName.numberOfLines=10;
//    companyName.text=@"工程署哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈啊哈哈哈哈哈";
    [scrollView2 addSubview:companyName];
    [companyName release];

    UILabel * label6=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    label6.text=@"类别:";
    [scrollView2 addSubview:label6];
    [label6 release];
    
    kind=[[UILabel alloc] initWithFrame:CGRectMake(50, 40, 100, 20)];
    [scrollView2 addSubview:kind];
    [kind release];
    
    UILabel * Label7=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
    Label7.text=@"规模:";
    [scrollView2 addSubview:Label7];
    
    scale=[[UILabel alloc] initWithFrame:CGRectMake(50, 60, 150, 20)];
    [scrollView2 addSubview:scale];
    [scale release];
    
    industry=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 320, 40)];
    industry.numberOfLines=5;
    industry.lineBreakMode=0;
    [scrollView2 addSubview:industry];
    [industry release];
    
    companyAddress=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 320, 40)];
    [scrollView2 addSubview:companyAddress];
    [companyAddress release];
    
    UIView * gapLine3=[[UIView alloc] initWithFrame:CGRectMake(0, 170, 320, 1)];
    gapLine3.backgroundColor=[UIColor grayColor];
    [scrollView2 addSubview:gapLine3];
    [gapLine3 release];
    
    UILabel * label8=[[UILabel alloc] initWithFrame:CGRectMake(10, 181, 80, 30)];
    label8.text=@"公司介绍";
    label8.font=[UIFont fontWithName:@"Arial" size:16];
    [scrollView2 addSubview:label8];
    [label8 release];
    
    companyDetailInfo=[[UILabel alloc] initWithFrame:CGRectMake(10, 211, 300, 600-211)];
    companyDetailInfo.numberOfLines=200;
    companyDetailInfo.lineBreakMode=0;
    [scrollView2 addSubview:companyDetailInfo];
    [companyDetailInfo release];

    
    scrollView2.hidden=YES;
    //该公司其他职位
    UIButton * otherjob=[UIButton buttonWithType:UIButtonTypeCustom];
    otherjob.frame=CGRectMake(0, 290, 320, 30);
    [otherjob addTarget:self action:@selector(getOtherJob:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:otherjob];
    
    UILabel * otherLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    otherLabel.text=@"该公司其他职位";
    otherLabel.userInteractionEnabled=YES;
    [otherjob addSubview:otherLabel];
    [otherLabel release];
//
    UIImageView * otherImg=[[UIImageView alloc] initWithFrame:CGRectMake(320-30, 5, 20, 20)];
    otherImg.userInteractionEnabled=YES;
    otherImg.image=[UIImage imageNamed:@"accessoryArrow"];
    [otherjob addSubview:otherImg];
    [otherImg release];
//
    UIView * gapLine2=[[UIView alloc] initWithFrame:CGRectMake(0, 290, 320, 1)];
    gapLine2.backgroundColor=[UIColor grayColor];
    [self.view addSubview:gapLine2];
    [gapLine2 release];
   
//    self.hidesBottomBarWhenPushed=YES;
//    self.tabBarController.tabBar.hidden=YES;
    [self.tabBarController.view viewWithTag:3000].hidden=YES;
    
    aView=[[UIView alloc] initWithFrame:CGRectMake(0, 480-49, 320, 49)];
    aView.backgroundColor=[UIColor blackColor];
    [self.tabBarController.view addSubview:aView];
    [aView release];
    
    UIImageView * cView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 320, 320, 50)];
    cView.image=[UIImage imageNamed:@"bottombar.png"];
    cView.userInteractionEnabled=YES;
    [self.view addSubview:cView];
    [cView release];
    
    
    for (int i=0; i<4; i++) {
        UIButton * bView=[[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 50)];
        bView.tag=4000+1000*i;
        [bView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:0];
        [bView addTarget:self action:@selector(jobOperation:) forControlEvents:UIControlEventTouchUpInside];
        [cView addSubview:bView];
        [bView release];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.identifier==@"2"||self.identifier==@"3"||self.identifier==@"4")
    {
//        NSLog(@"%@",self.Job_number);
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        [dic setObject:self.Job_number forKey:@"Job_number"];

        ZhiLianManager * manager=[[ZhiLianManager alloc] init];
        [manager setfinishBlock:^(id result, id result1, id result2) {
            self.dataArr=result;
//            NSLog(@"%@",result);
            jobName.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).job_title removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).job_title ];
            salary.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).salary_range removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).salary_range ];
            address.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).address removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).address ];
            exp.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).working_exp removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).working_exp ];
            perNum.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).number removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).number ];
            jobDetailInfo.text=((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).responsibility;
            
//            NSLog(@"%@",((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).responsibility);
            companyName.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_name removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_name ];
            kind.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_property removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_property ];
            scale.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_size removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_size ];
            
            industry.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).industry removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).industry ];
            companyAddress.text=[((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).address removeSpaceAndEnter:((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).address ];
            companyDetailInfo.text=((jobIntroduceAndCompanyIntroduceEntity *)[result objectAtIndex:0]).company_desc ;
        }];
        [manager getJobApplyDetailInfoWithURL:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx" withHttpMethod:@"GET" withParams:dic];
        [manager release];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -selffuc-
-(void)back:(UIButton *)sender
{
    if (self.identifier==@"1") {
        NSArray * arr=self.navigationController.viewControllers;
        [self.tabBarController.view viewWithTag:3000].hidden=NO;
        [aView removeFromSuperview];
        [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];
        return;
    }
    if (self.identifier==@"2") {
        NSArray * arr=self.navigationController.viewControllers;
        [self.tabBarController.view viewWithTag:3000].hidden=NO;
        [aView removeFromSuperview];
        [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];
         return;
    }
    if (self.identifier==@"3") {
        NSArray * arr=self.navigationController.viewControllers;
        [self.tabBarController.view viewWithTag:3000].hidden=NO;
        [aView removeFromSuperview];
        [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];
         return;
    }
    if (self.identifier==@"4") {
        NSArray * arr=self.navigationController.viewControllers;
        [self.tabBarController.view viewWithTag:3000].hidden=NO;
        [aView removeFromSuperview];
        [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];
        return;
    }

    [self.tabBarController.view viewWithTag:3000].hidden=NO;
    [aView removeFromSuperview];
    NSArray * arr=self.navigationController.viewControllers;
    [self.navigationController popToViewController:[arr objectAtIndex:2] animated:YES];

}
-(void)backFirstPage:(UIButton *)sender
{
    NSArray * arr=self.navigationController.viewControllers;
    [self.navigationController popToViewController:[arr objectAtIndex:0] animated:YES];
}
-(void)jobIntroduce:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"jobDescSelected.png"] forState:0];
    [companyIntroduce setBackgroundImage:[UIImage imageNamed:@"companyDescNormal.png"] forState:0];
    scrollView1.hidden=NO;
    scrollView2.hidden=YES;

}
-(void)companyIntroduce:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"companyDescSelected.png"] forState:0];
    [jobIntroduce setBackgroundImage:[UIImage imageNamed:@"jobDescNormal.png"] forState:0];
    scrollView2.hidden=NO;
    scrollView1.hidden=YES;

}

-(void)getOtherJob:(UIButton *)sender
{
//    NSLog(@"123");
}

-(void)jobOperation:(UIButton *)sender
{
    if (sender.tag==4000) {
        UIAlertView * success=[[UIAlertView alloc] initWithTitle:nil message:@"职位申请成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [success show];
        [success release];
        return;
        
    }
    
    if (sender.tag==5000) {
        UIAlertView * success=[[UIAlertView alloc] initWithTitle:nil message:@"收藏职位成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [success show];
        [success release];
        return;
        
    }
    

}

@end
