//
//  MyZLViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MyZLViewController.h"
#import "RegisterViewController.h"
#import "RequestData.h"
#import "LoginOutViewController.h"
#import "loginOutCell.h"
#import "ZhiLianManager.h"
#import "JobInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ResumeView.h"
#import "loginReturnInfoEntity.h"
#import "NSString+removeSaceAndEnter.h"
#import "scanResumeCompanyInfoViewController.h"
#import "uticketSingleTon.h"


@interface MyZLViewController ()

@end

@implementation MyZLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imgArr=[[NSArray alloc] initWithObjects:@"unreader.png",@"favorite.png",@"job_record.png",@"searchSubscribeViewController.png" ,nil];
        titleArr=[[NSArray alloc] initWithObjects:@"人事经理来信",@"职位申请记录",@"职位收藏夹",@"搜索与订阅", nil];
        infoArr=[[NSMutableArray alloc] init];
        subViews1=[[NSArray alloc] init];
        subViews2=[[NSArray alloc] init];
        self.resultArr=[[[NSMutableArray alloc] init] autorelease];
        resumeBtnTagArr=[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    [resumeBtnTagArr release];
    [_resultArr release];
    [subViews1 release];
    [subViews2 release];
    [_myTableView release];
    [_search release];
    [imgArr release];
    [titleArr release];
    [super dealloc];
    
}

-(void)loadView
{
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    self.title=@"我的智联";
    self.MyImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBg"]] autorelease];
    self.MyImageView.frame = CGRectMake(5, 5, 308, 107);
    self.MyImageView.userInteractionEnabled = YES;
    
    post = [[UITextField alloc] initWithFrame:CGRectMake(65, 6, 220, 40)];
    post.borderStyle = UITextBorderStyleRoundedRect;
    post.placeholder=@"请输入邮箱地址";
    post.text=@"897134699@qq.com";
//    post.text=@"basszhx3x@163.com";
    
    post.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.MyImageView addSubview:post];
    [post release];
    
    secret = [[UITextField alloc] initWithFrame:CGRectMake(65, 58, 220, 40)];
    secret.borderStyle = UITextBorderStyleRoundedRect;
    secret.placeholder=@"请输入密码";
    secret.text=@"485868jyl";
//    secret.text=@"325921";
    secret.secureTextEntry=YES;
    secret.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.MyImageView addSubview:secret];
    [self.view addSubview:self.MyImageView];
    [secret release];
    
    UIButton *LogInBnt = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [LogInBnt setBackgroundImage:[UIImage imageNamed:@"loginPress"] forState:(UIControlStateNormal)];
    [LogInBnt setBackgroundImage:[UIImage imageNamed:@"loginNormal"] forState:(UIControlStateSelected)];
    LogInBnt.frame = CGRectMake(5, 120, 142, 44);
    
    [LogInBnt setTitle:@"登录" forState:(UIControlStateNormal)];
    [LogInBnt addTarget:self
                 action:@selector(Login:)
       forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:LogInBnt];
    
    UIButton *Signin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    UIImageView *imv = [[UIImageView alloc] in]
    [Signin setBackgroundImage:[UIImage imageNamed:@"registerPress"] forState:(UIControlStateNormal)];
    [Signin setBackgroundImage:[UIImage imageNamed:@"registerNormal"] forState:(UIControlStateSelected)];
    Signin.frame = CGRectMake(170, 120, 142, 44);
    
    [Signin setTitle:@"注册新用户" forState:(UIControlStateNormal)];
    
    [Signin addTarget:self
               action:@selector(Register:)
     forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:Signin];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 170, 320, 200)];
    imageV.image = [UIImage imageNamed:@"xiaoren"];
    [self.view addSubview:imageV];
    [imageV release];

  

    rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame=CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"注销" forState:0];
    [rightButton setTitleColor:[UIColor whiteColor] forState:0];
    rightButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.hidden=YES;
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:rightButton] autorelease];
    
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
-(void)Login:(UIButton *)sender
{
  
    //退出键盘
    [self.view endEditing:YES];
    if (post.text==nil)
    {
        UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [noPost show];
        [noPost release];
        return;
    }
    
    if(post.text!=nil&&post.text.length<5)
        
    {
      UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"您输入的用户名不能少于5个字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [noPost show];
        [noPost release];
        return;
        
    }
    
  
    if (post.text!=nil&&secret.text==nil)
    {
        UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [noPost show];
        [noPost release];
        return;
    }
    
    
    if (post.text!=nil&&secret.text!=nil) {
     
        
        //网络请求，登陆更新页面数据
        NSMutableDictionary * params=[NSDictionary dictionaryWithObjectsAndKeys:post.text,@"loginname",secret.text,@"password",nil];
        ZhiLianManager * manager=[[ZhiLianManager  alloc]init];
        [manager setfinishBlock:^(id result, id result1,id result2) {
           // loginReturnInfoEntity *returnInfor = [result objectAtIndex:0];
          //  NSLog(@"%@",returnInfor.resume_name);
            
            self.resultArr=result;
            self.search=[result2 objectAtIndex:0];
            [uticketSingleTon share].uticket=self.search;
            
        //判断用户名或者密码是否输入正确
            if ([result  count]==0&&[result1 count]==0) {
                UIAlertView * alarm=[[UIAlertView alloc] initWithTitle:nil message:@"用户名或者密码输入错误，请检查!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil
                                     , nil];
                [alarm show];
                [alarm release];
                return ;
            }
            
            else
            {
                rightButton.hidden=NO;
                subViews1=self.view.subviews;
//                NSLog(@"%@",subViews1);
                for (int i=0; i<subViews1.count; i++) {
                    ( (UIView *)[subViews1 objectAtIndex:i]).hidden=YES;
                }
                
            //infoArr数据源
            NSMutableString * string1=[NSMutableString stringWithString:@"未读"];
            if ([result1 objectAtIndex:1]!=nil) {
                [string1 appendString:[result1 objectAtIndex:1]];
                [string1 appendString:@"  条"];
                [infoArr addObject:string1];
            }
            else
            {
                return ;
            }
            
            if ([result1 objectAtIndex:2]!=nil) {
                NSMutableString * string2=[result1 objectAtIndex:2];
                [string2 appendString:@"  条"];
                [infoArr addObject:string2];
            }
            else
            {
                return;
            }
            
            
            if ([result1 objectAtIndex:3]!=nil)
            {
                NSMutableString * string3=[result1 objectAtIndex:3];
                [string3 appendString:@"  条"];
                [infoArr addObject:string3];
            }
            else
            {
                return;
            }
            
            if ([result1 objectAtIndex:4]!=nil) {
                NSMutableString * string4=[result1 objectAtIndex:4];
                [string4 appendString:@"  条"];
                [infoArr addObject:string4];
            }
            else
            {
                return;
            }
            
            
            self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(10, 170, 300, 175) style:UITableViewStylePlain] autorelease];
            self.myTableView.delegate=self;
            self.myTableView.dataSource=self;
            self.myTableView.backgroundView.alpha=0;
            self.myTableView.layer.cornerRadius=10;
            [self.view addSubview:self.myTableView];
             
            // 简历界面以及配置
               // NSLog(@"%@",result);
                if ([result count]>0)
                {
                    //
                    resumeScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
                    resumeScrollView.contentSize=CGSizeMake(320*[result count], 90);
                    resumeScrollView.pagingEnabled=YES;
                    resumeScrollView.userInteractionEnabled=YES;
                    resumeScrollView.delegate=self;
                    [self.view addSubview:resumeScrollView];
                    [resumeScrollView release];
                    //
                    for (int i=0; i<[result count]; i++)
                    {
                      //  NSLog(@"%@",result);
                        ResumeView * resume=[[ResumeView alloc] initWithFrame:CGRectMake(0+320*i, 0, 320, 60)];
                        loginReturnInfoEntity *returnInfor = [result objectAtIndex:i];
                      //  NSLog(@"%@",returnInfor.show_count);
                        [resume.scanNum setTitle:[returnInfor.show_count removeSpaceAndEnter:returnInfor.show_count] forState:0];
                        
                        [resume.scanNum setTitleColor:[UIColor blackColor] forState:0];
                        [resume.scanNum addTarget:self action:@selector(scanCompany:) forControlEvents:UIControlEventTouchUpInside];
                        
                        NSArray * arr=[[returnInfor.resume_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@" "];
                        NSLog(@"%@",arr);
                        
                        NSMutableString * str=[NSMutableString stringWithString:[arr objectAtIndex:0]];
//                        NSLog(@"%@",str);
                       
                        if (1< [arr count]) {
                             [str appendString:@" "];
                            [str appendString:[arr objectAtIndex:1]];
 
                        }
                        if (2 < [arr count]) {
                            [str appendString:@" "];
                            [str appendString:[arr objectAtIndex:2]];

                        }
                                                resume.resumeName.text=str;
                        
                        //
                        [resume.refresh addTarget:self action:@selector(refreshResume:) forControlEvents:UIControlEventTouchUpInside];
                        resume.refresh.tag=i*1000+1000;
                         
                        
//                        NSLog(@"%@",[((loginReturnInfoEntity *)[result objectAtIndex:i]).isdefaultflag removeSpaceAndEnter:((loginReturnInfoEntity *)[result objectAtIndex:i]).isdefaultflag]);
                        //可能存在bug
                        if ([[((loginReturnInfoEntity *)[result objectAtIndex:i]).isdefaultflag removeSpaceAndEnter:((loginReturnInfoEntity *)[result objectAtIndex:i]).isdefaultflag]integerValue]==1) {
                            [resume.setResume setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
                            resume.setResume.backgroundColor=[UIColor clearColor];
                        }
                        [resume.setResume addTarget:self action:@selector(setDefaultResume:) forControlEvents:UIControlEventTouchUpInside];
                        resume.setResume.tag=i*1001+1001;
                        [resumeBtnTagArr addObject:[NSString stringWithFormat:@"%d",resume.setResume.tag]];
                        [resumeScrollView addSubview:resume];
                        [resume release];
                    }
                    
                    //
                    if ([result count]>0) {
                        resumePageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(110, 120, 100, 20)];
                        resumePageControl.numberOfPages=[result count];
                        resumePageControl.currentPage=0;
                        [resumePageControl addTarget:self action:@selector(changeScrollViewContentsize:) forControlEvents:UIControlEventValueChanged];
                        [self.view addSubview:resumePageControl];
                        [resumePageControl release];
                    }
                
                   
                }

            
            
            if ([result objectAtIndex:0]==@"") {
                UILabel * label1=[[UILabel alloc] init];
                label1.text=@"你还没有简历,请登录:";
                label1.backgroundColor=[UIColor clearColor];
                label1.font=[UIFont fontWithName:@"Arial"  size:14];
                label1.frame=CGRectMake(20, 30, 150, 20);
                [self.view addSubview:label1];
                [label1 release];
                
                UILabel * label2=[[UILabel alloc] init];
                label2.text=@"http://www.zhaopin.com";
                label2.font=[UIFont fontWithName:@"Arial" size:14];
                label2.backgroundColor=[UIColor clearColor];
                label2.frame=CGRectMake(20, 50, 150, 20);
                [self.view addSubview:label2];
                [label2 release];
                
                UILabel * label3=[[UILabel alloc] init];
                label3.text=@"填写完整简历";
                label3.font=[UIFont fontWithName:@"Arial" size:14];
                label3.backgroundColor=[UIColor clearColor];
                label3.frame=CGRectMake(20, 70, 150, 20);
                [self.view addSubview:label3];
                [label3 release];
            }}
        }];
        [manager loginReturnInforequestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx" withHttpMethod:@"GET" withParams:params];
        [manager release];

    }
    }

-(void)Register:(UIButton *)sender
{
    RegisterViewController * root=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:root animated:YES];
  
    [root release];

}

#pragma mark -tableView-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"cell";
    loginOutCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil==cell) {
        cell=[[[loginOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.imageView.image=[UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
    cell.title.text=[titleArr objectAtIndex:indexPath.row];
    cell.info.text=[infoArr objectAtIndex:indexPath.row];
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    JobInfoViewController *root=[[JobInfoViewController alloc] initWithIndexPath:indexPath];
    //将uticket传过去
    root.search=self.search;

    [self.navigationController pushViewController:root animated:YES];
    [root release];
}
#pragma mark -scrollView-
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    resumePageControl.currentPage=scrollView.contentOffset.x/320;
}

-(void)changeScrollViewContentsize:(UIPageControl *)sender
{
    resumeScrollView.contentOffset=CGPointMake(sender.currentPage*320, 0);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        if (buttonIndex==0)
        {
            return;
        }
        
        if(buttonIndex==1)
        {
            subViews2=self.view.subviews;
//            NSLog(@"%@",subViews2);
            for (int i=0; i<subViews2.count; i++)
            {
                ((UIView *)[subViews2 objectAtIndex:i]).hidden=YES;
            }
            
            for (int i=0; i<4; i++) {
                ((UIView *)[subViews2 objectAtIndex:i]).hidden=NO;
            }
            
            post.text=nil;
            secret.text=nil;
            self.search=nil;
            rightButton.hidden=YES;
            return;
        }
        

    }
 
    //设置默认简历
    if (wheatherBtn.backgroundColor==[UIColor whiteColor]) {
        if (buttonIndex==0)
        {
            return;
        }
        
        if(buttonIndex==1)
        {
            //将其他的设置默认简历按钮设成未打钩
            NSMutableArray * arr=resumeBtnTagArr;
//            NSLog(@"%@",arr);
          
            [arr removeObject:[NSString stringWithFormat:@"%d",wheatherBtn.tag]];

           
//            NSLog(@"%@",arr);
            if ([arr count]>0) {
                for (int i=0; i<[arr count]; i++)
                {
//                    NSLog(@"%@",[resumeScrollView viewWithTag:[[arr objectAtIndex:i] integerValue]]);
                    
                        UIButton * btn=(UIButton *)[resumeScrollView viewWithTag:[[arr objectAtIndex:i] integerValue]] ;
                       
                        [btn  setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
                        btn.backgroundColor=[UIColor whiteColor];

                }
            }
            
            wheatherBtn.backgroundColor=[UIColor clearColor];
            [wheatherBtn setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
            [arr addObject:[NSString stringWithFormat:@"%d",wheatherBtn.tag]];
            NSMutableDictionary * dic=[NSMutableDictionary dictionary];
//            NSLog(@"%d",alertView.tag);
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_id removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_id] forKey:@"resume_id"];
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_number] forKey:@"Resume_number"];
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).version_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).version_number]  forKey:@"Version_number"];
            [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/setdefaultresume.aspx" withHttpMethod:@"GET" withParams:dic];
            [data setResultData:^(id aid, NSError *error) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                if ([[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"] removeSpaceAndEnter:[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]] integerValue]==1) {
                    
                    [self alarmAnimation:@"默认简历设置成功"];
                }
                
            }];
            [data connect];
            
        }

    }
    else
    {
    
        if (buttonIndex==0)
        {
            return;
        }
        
        if(buttonIndex==1)
        {
            wheatherBtn.backgroundColor=[UIColor whiteColor];
            [wheatherBtn setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
            NSMutableDictionary * dic=[NSMutableDictionary dictionary];
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_id removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_id] forKey:@"resume_id"];
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).resume_number] forKey:@"Resume_number"];
            [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).version_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:alertView.tag]).version_number]  forKey:@"Version_number"];
            [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/setdefaultresume.aspx" withHttpMethod:@"GET" withParams:dic];
            [data setResultData:^(id aid, NSError *error) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                if ([[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"] removeSpaceAndEnter:[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]] integerValue]==1) {
                    
                    [self alarmAnimation:@"取消默认简历成功"];
                }
                
            }];
            [data connect];
            
        }

    }
   }

#pragma mark -selffunc-
-(void)loginOut:(UIButton *)sender
{
    UIAlertView * loginOut=[[UIAlertView alloc] initWithTitle:nil message:@"是否确认注销？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    loginOut.tag=1000;
    loginOut.delegate=self;
    [loginOut show];
    [loginOut release];
    
}

//设置简历
-(void)refreshResume:(UIButton *)sender
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:(sender.tag-1000)/1000]).resume_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:(sender.tag-1000)/1000]).resume_number] forKey:@"Resume_number"];
    [dic setObject:[((loginReturnInfoEntity *)[self.resultArr objectAtIndex:(sender.tag-1000)/1000]).version_number removeSpaceAndEnter:((loginReturnInfoEntity *)[self.resultArr objectAtIndex:(sender.tag-1000)/1000]).version_number]  forKey:@"Resume_version"];
    [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/resume_refresh.aspx" withHttpMethod:@"GET" withParams:dic];
    [data setResultData:^(id aid, NSError *error) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if ([[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"] removeSpaceAndEnter:[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]] integerValue]==1) {
       
            [self alarmAnimation:@"简历刷新成功"];
        }
        
    }];
    [data connect];

}
-(void)setDefaultResume:(UIButton *)sender
{
    
    if (sender.backgroundColor==[UIColor whiteColor])
    {
    wheatherBtn=sender;
    
    UIAlertView * setResume=[[UIAlertView alloc] initWithTitle:nil message:@"默认简历只能设置一份,确认设置钙粉简历为默认简历吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    setResume.tag=(wheatherBtn.tag-1001)/1001;
    [setResume show];
    [setResume release];
    return;
                              
    }
    
    if (sender.backgroundColor==[UIColor clearColor])
    {
        wheatherBtn=sender;
        
        UIAlertView * setResume1=[[UIAlertView alloc] initWithTitle:nil message:@"确认要取消默认简历?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        setResume1.tag=(wheatherBtn.tag-1001)/1001;
        [setResume1 show];
        [setResume1 release];
        return;
        
    }
   

}

-(void)scanCompany:(UIButton *)sender
{
   
    scanResumeCompanyInfoViewController * root=[[scanResumeCompanyInfoViewController alloc] init];
    root.pageSize=sender.currentTitle;
    root.search=[self.search removeSpaceAndEnter:self.search];
    [self.navigationController pushViewController:root animated:YES];
    [root release];

}

//刷新，设置成功的小动画
-(void)alarmAnimation:(NSString * )sender
{
    alarmView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    alarmView.center=self.view.center;
    alarmView.backgroundColor=[UIColor clearColor];
    alarmView.layer.cornerRadius=5;
    [self.view addSubview:alarmView];
    [alarmView release];
    
    alarmView1=[[UIView alloc] initWithFrame:alarmView.bounds];
    alarmView1.backgroundColor=[UIColor blackColor];
    alarmView1.layer.cornerRadius=5;
    alarmView1.alpha=0.8;
    [alarmView addSubview:alarmView1];
    
    UILabel * label=[[UILabel alloc] initWithFrame:alarmView.bounds];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.text=sender;
    label.textAlignment=NSTextAlignmentCenter;
    [alarmView1 addSubview:label];
    [label release];
    [self removeAlarmAnimation];
   
}

-(void)removeAlarmAnimation
{
    //会出现bug
    [UIView animateWithDuration:1.5 animations:^{
         alarmView1.alpha=0;
    } completion:^(BOOL finished) {
        ;
    }];
   

}

@end
