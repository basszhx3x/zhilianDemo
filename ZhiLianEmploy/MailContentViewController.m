//
//  MailContentViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MailContentViewController.h"
#import "ZhiLianManager.h"
#import "NSString+removeSaceAndEnter.h"
#import "RequestData.h"
#import "mailContentEntity.h"

@interface MailContentViewController ()

@end

@implementation MailContentViewController

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
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 50, 30);
    [back setTitle:@"返回" forState:0];
    [back setTitleColor:[UIColor whiteColor] forState:0];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:back] autorelease];
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    scrollView.contentSize=CGSizeMake(320, 700);
    [self.view addSubview:scrollView];
    [scrollView release];
    
    
    UILabel * title=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    title.text=@"主题:";
    [scrollView addSubview:title];
    [title release];
    
    //
    
    UIView * gapLine=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
    gapLine.backgroundColor=[UIColor grayColor];
    [scrollView addSubview:gapLine];
    [gapLine release];
    
    UILabel * come=[[UILabel alloc] initWithFrame:CGRectMake(10, 51, 40, 20)];
    come.text=@"来自:";
    [scrollView addSubview:come];
    [come release];
    //
    
    UIView * gapLine1=[[UIView alloc] initWithFrame:CGRectMake(0, 81, 320, 1)];
    gapLine1.backgroundColor=[UIColor grayColor];
    [scrollView addSubview:gapLine1];
    [gapLine1 release];
    
    UILabel * sendTime=[[UILabel alloc] initWithFrame:CGRectMake(10, 92, 80, 20)];
    sendTime.text=@"发送时间:";
    [scrollView addSubview:sendTime];
    [sendTime release];
    
    //
    UIView * gapLine2=[[UIView alloc] initWithFrame:CGRectMake(0, 122, 320, 1)];
    gapLine2.backgroundColor=[UIColor grayColor];
    [scrollView addSubview:gapLine2];
    [gapLine2 release];
    //
    
    
    
 

    //网络请求
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObject:[self.uticket removeSpaceAndEnter:self.uticket] forKey:@"uticket"];
    [dic setObject:[self.email_number removeSpaceAndEnter:self.email_number] forKey:@"email_number"];
    [dic setObject:[self.Company_name removeSpaceAndEnter:self.Company_name] forKey:@"Company_name"];
    [dic setObject:[self.Is_read removeSpaceAndEnter:self.Is_read] forKey:@"Is_read"];
    
    ZhiLianManager * manager=[[ZhiLianManager alloc] init];
    [manager setfinishBlock:^(id result, id result1, id result2)
     {
         self.dataArr=result;
         //
         UILabel * title1=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
         title1.text=[((mailContentEntity *)[self.dataArr objectAtIndex:0]).subject  removeSpaceAndEnter:((mailContentEntity *)[self.dataArr objectAtIndex:0]).subject];
         [scrollView addSubview:title1];
         [title1 release];
         
         //
         UILabel * come1=[[UILabel alloc] initWithFrame:CGRectMake(50, 51, 200, 20)];
         come1.text=[((mailContentEntity *)[self.dataArr objectAtIndex:0]).company_name  removeSpaceAndEnter:((mailContentEntity *)[self.dataArr objectAtIndex:0]).company_name];
         [scrollView addSubview:come1];
         [come1 release];
         
         //
         UILabel * time1=[[UILabel alloc] initWithFrame:CGRectMake(70, 92, 200, 20)];
         time1.backgroundColor=[UIColor clearColor];
         time1.text=((mailContentEntity *)[self.dataArr objectAtIndex:0]).date_posted;
         time1.textAlignment=NSTextAlignmentLeft;
         [scrollView addSubview:time1];
         [time1 release];
         
         //
         UILabel * content=[[UILabel alloc] initWithFrame:CGRectMake(10, -20, 300, 700-133)];
         content.text=((mailContentEntity *)[self.dataArr objectAtIndex:0]).mail_body;
         content.backgroundColor=[UIColor clearColor];
         content.lineBreakMode=0;
         content.numberOfLines=1000;
         [scrollView addSubview:content];
         [content release];
         
         
         
        
         
     }];
    [manager getMailContentWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_showmail.aspx" withHttpMethod:@"GET" withParams:dic];
    [manager release];

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

#pragma mark -selffunc-
-(void)back:(UIButton *)sender
{
    NSArray * arr=self.navigationController.viewControllers;
    [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];

}

@end
