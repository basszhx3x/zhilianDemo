//
//  CompanyDetailInfoViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "MapKitViewController.h"
#import "OtherJobChristopherViewController.h"
#import "CompanyDetailInfoViewControllerzhx.h"
#import "RequestData.h"
#import "RequestDataforRealtime.h"
#import "CompanyEntry.h"
#import "SearchsamejobViewController.h"
@interface CompanyDetailInfoViewControllerzhx ()

@end

@implementation CompanyDetailInfoViewControllerzhx

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.jobListArr = [NSMutableArray array];
    }
    return self;
}
-(void)dealloc
{   [_jobListArr release];_jobListArr = nil;
    [myclass release];myclass=nil;

    [super dealloc];
}
-(void)loadView
{
    isOtherJob = NO;
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    myclass = [[MyClassUseOften alloc]init];
    [self.jobListArr setArray:self.companyDetail.joblist];
    
       
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [aView removeFromSuperview];
    
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
}
-(void)Btn0jobOperation:(UIButton *)aBtn
{
    

}
-(void)Btn1jobOperation:(UIButton *)aBtn
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.uiuticket forKey:@"uticket"];
    [dic setObject:self.Job_number forKey:@"job_number"];
    // NSLog(@"%@",dic);
    RequestDataforRealtime *request = [RequestDataforRealtime requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/job/collectposition.aspx" withHttpMethod:@"GET" withParams:dic];
    [request setResultData:^(id aid, NSError *error) {
        id aID=  [myclass xMlResultDictionaryWithDic:aid withKey:@"message"];
        if (aID) {
            [myclass showTip:[myclass removeHeadAndTailWhitespaceAndNewlineCharacter:[aID objectForKey:@"text"]] withPosition:CGRectMake(160-100, (480-44-20-49)/2-40, 200, 40) withSuperView:self.view];
        }
        
        
    }];
    [request connect];
}
-(void)Btn2jobOperation:(UIButton *)aBtn
{   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.Job_number forKey:@"Job_number"];
    [dic setObject:@"1" forKey:@"Page"];
    [dic setObject:@"10" forKey:@"Pagesize"];
    RequestData *request = [RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/search/searchsamejob.aspx" withHttpMethod:@"GET" withParams:dic];
    [request setResultData:^(id aid, NSError *error) {
        
      //  NSLog(@"%@",aid);
        SearchsamejobViewController *sameJob = [[SearchsamejobViewController alloc]init];
        id AID = [myclass xMlResultDictionaryWithDic:aid withKey:@"position"];
         //NSLog(@"%@",AID);
        if (AID && [AID isKindOfClass:[NSArray class]]) {
            [ sameJob.Source setArray: AID];
            sameJob.utiket = self.uiuticket;
            [self.navigationController pushViewController:sameJob animated:YES];

        }
        else
        {
            [myclass showTip:@"该公司无其它招聘职位" withPosition:CGRectMake(100,150,150,40) withSuperView:self.view];
            
        }
       
        [sameJob release];
        
    }];
    [request connect];

}
-(void)Btn3jobOperation:(UIButton *)aBtn
{
        
    MapKitViewController *map = [[MapKitViewController alloc]init];
    NSLog(@"%@",self.companyDetail.job_longitude);
    NSLog(@"%@",self.companyDetail.job_latitude);
    map.currentlatitude =[[myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_latitude] doubleValue];
   // NSLog(@"%f",latitudeA);
   // map.currentlatitude = latitudeA;
 //   NSLog(@"%@",map.currentlongitude);
    map.currentlongitude = [[myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_longitude] doubleValue];
    [self.navigationController pushViewController:map animated:YES];
    [map release];
    
    
    
}

-(void)fontNameSize:(CGFloat)floatA withVIew:(UILabel *)aaView

{
    aaView.font = [UIFont fontWithName:@"Arial" size:floatA];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.view viewWithTag:3000].frame = CGRectMake(0, 480-49, 320, 49);
    [self.tabBarController.view viewWithTag:3000].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bigdownPic.png"]];

    
    //该公司其他职位
    NSLog(@"%@",self.jobListArr);
   
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
    scrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 480-20-44-49-30-30-20)];
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
    jobName.text=[myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_title];
    [scrollView1 addSubview:jobName];
    [jobName release];
    
    UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    NSString *salaryText = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_salary_range];
    
    
    label1.text=@"月薪:";
    [scrollView1 addSubview:label1];
    [label1 release];
    
    salary=[[UILabel alloc] initWithFrame:CGRectMake(50, 40, 200, 20)];
    if ([salaryText isEqualToString:@"面议"]) {
        salary.text = [NSString stringWithFormat:@"%@",salaryText];
        
    }
    else
    {
        salary.text = [NSString stringWithFormat:@"%@ 元/月",salaryText];
    }
    [scrollView1 addSubview:salary];
    [salary release];
    
    //    UILabel * label5=[[UILabel alloc] initWithFrame:CGRectMake(150, 40, 40, 20)];
    //    label5.text=@"元/月";
    //    [scrollView1 addSubview:label5];
    //    [label5 release];
    
    
    
    UILabel * label2=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
    label2.text=@"地点:";
    [scrollView1 addSubview:label2];
    [label2 release];
    
    address=[[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 20)];
    
    address.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_city];
    
    [scrollView1 addSubview:address];
    [address release];
    
    UILabel * label3=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
    label3.text=@"经验:";
    [scrollView1 addSubview:label3];
    [label3 release];
    exp=[[UILabel alloc] initWithFrame:CGRectMake(50, 80, 100, 20)];
    exp.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_working_exp];
    [scrollView1 addSubview:exp];
    [exp release];
    
    UILabel * label4=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 40, 20)];
    label4.text=@"人数:";
    [scrollView1 addSubview:label4];
    [label4 release];
    
    perNum=[[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 20)];
    perNum.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.job_numberPerson];
    
    [scrollView1 addSubview:perNum];
    [perNum release];
    
    UIView * gapLine=[[UIView alloc] initWithFrame:CGRectMake(0, 130, 320, 1)];
    gapLine.backgroundColor=[UIColor grayColor];
    [scrollView1 addSubview:gapLine];
    [gapLine release];
    
    jobDetailInfo=[[UILabel alloc] initWithFrame:CGRectMake(15, 140, 280, 600-131)];
    
    // NSLog(@"%@",self.companyDetail.job_responsibility);
    /*
     label_1.numberOfLines=0;
     CGSize size = [label_1 sizeThatFits:CGSizeMake(100, 0)];//假定label_1设置的固定宽度为100，自适应高
     [label.textsizeWithFont:label.font
     constrainedToSize:size
     lineBreakMode:UILineBreakModeWordWrap]; //这句加上才能自适应
     NSLog(@"字符在宽度不变，自适应高：%f",size.height);
     CGRect rct = label_1.frame;
     rct.size.height=size.height;
     label_1.frame = rct; //把得到的高赋给label_1
     */
    jobDetailInfo.font = [UIFont fontWithName:@"Arial" size:14.0f];
    jobDetailInfo.text = [myclass removeStringAllWhitespaceAndNewlineCharacter:self.companyDetail.job_responsibility];
    jobDetailInfo.numberOfLines=0;
    jobDetailInfo.text = [jobDetailInfo.text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    CGSize size = [jobDetailInfo sizeThatFits:CGSizeMake(280, 0)];
    [jobDetailInfo.text sizeWithFont:[UIFont fontWithName:@"Arial" size:14.0f] constrainedToSize:size];
    jobDetailInfo.lineBreakMode=NSLineBreakByWordWrapping;
    
    CGRect rect = jobDetailInfo.frame;
    rect.size.height = size.height;
    jobDetailInfo.frame = rect;
    //jobDetailInfo.text = texta;
    
    
    [scrollView1 addSubview:jobDetailInfo];
    
    UIView * bottomgapLine=[[UIView alloc] initWithFrame:CGRectMake(0, 140+size.height+10, 320, 1)];
    bottomgapLine.backgroundColor=[UIColor grayColor];
    [scrollView1 addSubview:bottomgapLine];
    [bottomgapLine release];
    
    
    scrollView2=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 480-20-44-49-30-50)];
    scrollView2.backgroundColor=[UIColor whiteColor];
    scrollView2.contentSize=CGSizeMake(0, 1200);
    [self.view addSubview:scrollView2];
    //搭建scrollView2的UI
    companyName=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    companyName.textColor=[UIColor orangeColor];
    companyName.textAlignment=NSTextAlignmentLeft;
    //设置自动换行
    companyName.lineBreakMode=NSLineBreakByWordWrapping;
    companyName.numberOfLines=10;
    companyName.text=[myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.company_name];
    [scrollView2 addSubview:companyName];
    [companyName release];
    
    UILabel * label6=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    label6.text=@"类别:";
    label6.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [scrollView2 addSubview:label6];
    [label6 release];
    
    kind=[[UILabel alloc] initWithFrame:CGRectMake(50, 40, 320-60, 30)];
    kind.numberOfLines = 2;
    kind.lineBreakMode = NSLineBreakByWordWrapping;
    kind.font = [UIFont fontWithName:@"Arial" size:12.0f];
    kind.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.company_industry];
    [scrollView2 addSubview:kind];
    [kind release];
    
    UILabel * Label7=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, 40, 20)];
    Label7.text=@"规模:";
    [self fontNameSize:14.0f withVIew:Label7];
    [scrollView2 addSubview:Label7];
    
    scale=[[UILabel alloc] initWithFrame:CGRectMake(50, 70, 320, 20)];
    [self fontNameSize:12.0f withVIew:scale];
    scale.text = [myclass removeStringAllWhitespaceAndNewlineCharacter:self.companyDetail.company_size];
    [scrollView2 addSubview:scale];
    [scale release];
    
    industry=[[UILabel alloc] initWithFrame:CGRectMake(10, 95, 300, 35)];
    industry.numberOfLines=3;
    industry.lineBreakMode=0;
    [self fontNameSize:14.0f withVIew:industry];
    NSString *strA = @"公司地址:";
    industry.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.company_address];
    industry.text = [strA stringByAppendingString:industry.text];
    //industry.text =[myclass removeStringAllWhitespaceAndNewlineCharacter:self.companyDetail.company_size];
    [scrollView2 addSubview:industry];
    [industry release];
    
    companyAddress=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 320, 30)];
    [self fontNameSize:12.0f withVIew:companyAddress];
    // companyAddress.text = [myclass removeHeadAndTailWhitespaceAndNewlineCharacter:self.companyDetail.company_address];
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
    
    companyDetailInfo=[[UILabel alloc] initWithFrame:CGRectMake(15, 211, 280, 600-211)];
    companyDetailInfo.text = [myclass removeStringAllWhitespaceAndNewlineCharacter:self.companyDetail.company_company_desc];
    companyDetailInfo.text = [companyDetailInfo.text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    
    
    companyDetailInfo.frame = [myclass LableSizeFitsAdapt:companyDetailInfo withFontName:@"Arial" withFontSize:14.0f];
    
    
    [scrollView2 addSubview:companyDetailInfo];
    [companyDetailInfo release];
    
    
    scrollView2.hidden=YES;
    UIButton * otherjob=[UIButton buttonWithType:UIButtonTypeCustom];
    otherjob.backgroundColor=[UIColor whiteColor];
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
    aView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    aView.backgroundColor=[UIColor blackColor];
    // [self.view addSubview:aView];
    [[self.tabBarController.view viewWithTag:3000] addSubview:aView];
    
    UIImageView * cView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 320, 320, 50)];
    cView.image=[UIImage imageNamed:@"bottombar.png"];
    cView.userInteractionEnabled=YES;
    [self.view addSubview:cView];
    [cView release];
    
    
    for (int i=0; i<4; i++) {
        UIButton * bView=[[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 50)];
        
        [bView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:0];
        // NSString *action = [NSString stringWithFormat:@"jobOperation%d",i];
        SEL select = NSSelectorFromString([NSString stringWithFormat:@"Btn%djobOperation:",i ]);
        //NSLog(@"%@",[NSString stringWithFormat:@"Btn%djobOperation",i ]);
        [bView addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
        //        bView.backgroundColor=[UIColor redColor];
        [cView addSubview:bView];
        [bView release];
    }
    



}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -selffuc-
-(void)back:(UIButton *)sender
{
    [aView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];


   // [self.navigationController popToViewController:[arr objectAtIndex:0] animated:YES];
}
-(void)backFirstPage:(UIButton *)sender
{
    NSArray * arr=self.navigationController.viewControllers;
    [self.tabBarController.view viewWithTag:3000].hidden=NO;

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
    OtherJobChristopherViewController *otherjob = [[OtherJobChristopherViewController alloc]init];
   // NSLog(@"%@",self.companyDetail.joblist);
    otherjob.delegate = self;
    isOtherJob = NO;
    [otherjob.jobsArray setArray:self.companyDetail.joblist];
    [self.navigationController pushViewController:otherjob animated:YES];
}
-(void)OtherJobChristopherViewController:(OtherJobChristopherViewController *)otherjob withcompany:(CompanyEntry *)aCompany withIsOtherJob:(BOOL)isList
{
    
    if (isList) {
       // isOtherJob = isList;
        self.companyDetail = aCompany;
    }
    
    
}


@end
