//
//  JobInfoViewController.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "JobInfoViewController.h"
#import "CreatJobSearchorViewController.h"
#import "RequestData.h"
#import "NSString+removeSaceAndEnter.h"
#import "ZhiLianManager.h"
#import "jobSearchEntity.h"
#import "JobSearchorCell.h"
#import "JobSearchorCell1.h"
#import "LasteastJobViewController.h"
#import "jobApplyCell.h"
#import "JobApplyRecord.h"
#import "favJobCell.h"
#import "favJobDeleteCell.h"
#import "jobCollectionEntity.h"
#import "managerOfferCell.h"
#import "managerOfferEntity.h"
#import "managerOfferDeleteCell.h"
#import "MailContentViewController.h"
#import "CompanyDetailInfoViewController.h"
@interface JobInfoViewController ()

@end

@implementation JobInfoViewController
@synthesize indexPath=_indexPath;

-(id)initWithIndexPath:(NSIndexPath *)aIndexPath
{
    if (self=[super init])
    {
        self.indexPath=aIndexPath;
        self.searchArr=[[[NSMutableArray alloc] init] autorelease];
        self.jobApplyArr=[[[NSMutableArray alloc] init] autorelease] ;
        wheatherDelete=YES;
        
        takeDaysArr=[[NSMutableArray alloc] initWithObjects:@"不订阅",@"订阅1天",@"订阅3天",@"订阅7天", nil];
        wheatherFirstPickArr=[[NSMutableArray alloc] init];
        chooseJobBack=[[NSMutableArray alloc] init];
    }
    return self;
}


-(void)dealloc
{
    [_indexPath release];
    [_search release];
    [_jobApplyArr release];
    [_searchArr release];
    [chooseJobBack release];
    [wheatherFirstPickArr release];
    [takeDaysArr release];
  
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
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:back] autorelease];
    
    
    edit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    edit.frame=CGRectMake(0, 0, 50, 30);
    [edit setTitle:@"编辑" forState:0];
    [edit setTitleColor:[UIColor whiteColor] forState:0];
    edit.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [edit setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [edit setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:edit] autorelease];

//    NSLog(@"%d",self.indexPath.row);
    //判断是哪个cell过来的
    if (self.indexPath.row==0) {
        self.title=@"收件箱";
        [self loadPic];
        NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObject:[self.search removeSpaceAndEnter:self.search] forKey:@"uticket"];
        [dic setObject:@"1" forKey:@"Page"];
        [dic setObject:@"20" forKey:@"Pagesize"];
        ZhiLianManager * manager=[[ZhiLianManager alloc] init];
        [manager setfinishBlock:^(id result, id result1, id result2) {
//            NSLog(@"%@",result);
            [self hiddenLoad];
            self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44) style:UITableViewStylePlain] autorelease] ;
            self.myTableView.delegate=self;
            self.myTableView.dataSource=self;
            self.myTableView.sectionHeaderHeight=0;
            [self.view addSubview:self.myTableView];
            self.jobApplyArr=result;
            [self.myTableView reloadData];
        }];
        [manager managerOfferWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/get_hr_email_list.aspx" withHttpMethod:@"GET" withParams:dic];
        [manager release];

        
    }
    
    if (self.indexPath.row==1)
    {    
        self.navigationItem.rightBarButtonItem.customView.hidden=YES;
        
        [self loadPic];
        self.title=@"职位申请记录";
        NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObject:[self.search removeSpaceAndEnter:self.search] forKey:@"uticket"];
        [dic setObject:@"1" forKey:@"Page"];
        [dic setObject:@"20" forKey:@"Pagesize"];
        ZhiLianManager * manager=[[ZhiLianManager alloc] init];
        [manager setfinishBlock:^(id result, id result1, id result2) {
            [self hiddenLoad];
            self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44) style:UITableViewStylePlain] autorelease] ;
            self.myTableView.delegate=self;
            self.myTableView.dataSource=self;
            self.myTableView.sectionHeaderHeight=0;
            [self.view addSubview:self.myTableView];
             self.jobApplyArr=result;
            [self.myTableView reloadData];
        }];
        [manager JobApplyRecordJobWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_applist.aspx" withHttpMethod:@"GET" withParams:dic];
            [manager release];
        
       
        
    
    }
    
    if (self.indexPath.row==2) {
        self.title=@"职位收藏夹";
                
        [self loadPic];
        NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObject:[self.search removeSpaceAndEnter:self.search] forKey:@"uticket"];
        [dic setObject:@"1" forKey:@"Page"];
        [dic setObject:@"10" forKey:@"Pagesize"];
        ZhiLianManager * manager=[[ZhiLianManager alloc] init];
        [manager setfinishBlock:^(id result, id result1, id result2) {
            [self hiddenLoad];
            self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44) style:UITableViewStylePlain] autorelease] ;
            self.myTableView.delegate=self;
            self.myTableView.dataSource=self;
            self.myTableView.sectionHeaderHeight=0;
            [self.view addSubview:self.myTableView];

//            NSLog(@"%@",result);
            self.jobApplyArr=result;
            [self.myTableView reloadData];
        }];
        [manager FavorJobWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_list.aspx" withHttpMethod:@"GET" withParams:dic];
        [manager release];


        
        
        
    }
    
    if (self.indexPath.row==3) {
        self.title=@"搜索与订阅";
        UIImageView * jobSearchImg=[[UIImageView alloc] initWithFrame:CGRectMake(80, 10, 20, 20)];
        jobSearchImg.userInteractionEnabled=YES;
        jobSearchImg.backgroundColor=[UIColor clearColor];
        jobSearchImg.image=[UIImage imageNamed:@"addSearcher.png"];
        [self.view addSubview:jobSearchImg];
        [jobSearchImg release];
        
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [jobSearchImg addGestureRecognizer:tap];
        [tap release];
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(80+30, 10, 150, 20)];
        label.text=@"创建职位搜索器";
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont fontWithName:@"Arial" size:16];
        [self.view addSubview:label];
        [label release];
        
        UIImageView * gapLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 2)];
        gapLine.image=[UIImage imageNamed:@"searchHistoryUpLine.png"];
        [self.view addSubview:gapLine];
        [gapLine release];
        
                
        //添加月薪选择器
        self.myActionSheet=[[[UIActionSheet alloc]init] autorelease];
        }
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //获取职位申请列表
    if (self.indexPath.row==1) {
         
       
    }
    
    //处理网络数据
    if (self.indexPath.row==3)
    {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
//        NSLog(@"%@",self.search);
        [self.search removeSpaceAndEnter:self.search];
//        NSLog(@"%@",[self.search removeSpaceAndEnter:self.search]);
        NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObject:[self.search removeSpaceAndEnter:self.search] forKey:@"uticket"];
        [self loadPic];
        
        ZhiLianManager * manager=[[ZhiLianManager alloc] init];
        [manager setfinishBlock:^(id result, id result1, id result2)
         {
             [self hiddenLoad];
             self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 480-49-40-44) style:UITableViewStyleGrouped] autorelease];
             self.myTableView.backgroundView.alpha=0;
             self.myTableView.delegate=self;
             self.myTableView.dataSource=self;
             self.myTableView.sectionHeaderHeight=30;
             [self.view addSubview:self.myTableView];

             self.searchArr=result;
//             NSLog(@"%d",[self.searchArr count]);
             [self.myTableView reloadData];
             
         }];
        [manager jobSearchWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobsearcher.aspx" withHttpMethod:@"GET" withParams:dic];
        [manager release];
        
    }
    


}



//tableViewdelegate方法写了，必须要实现
#pragma mark -tableViewDelegate-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.indexPath.row==3)
    {
         return [self.searchArr count];
    }
    else
    {
        return 1;
    }
 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.indexPath.row==3)
    {
        return 1;
    }
    
    else {
        return [self.jobApplyArr count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.indexPath.row==0&&wheatherDelete==YES)
    {
        static NSString * cellIdentifier=@"cell";
        managerOfferCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[managerOfferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        cell.offerName.text=[((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).subject removeSpaceAndEnter:((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).subject];
        cell.companyName.text=[((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name];
        cell.date.text=((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).date_posted ;

        return cell;
    }
    if (self.indexPath.row==0&&wheatherDelete==NO)
    {
        static NSString * cellIdentifier1=@"cell1";
        managerOfferDeleteCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell) {
            cell=[[[managerOfferDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        cell.offerName.text=[((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).subject removeSpaceAndEnter:((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).subject];
        cell.companyName.text=[((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name];
        cell.date.text=((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).date_posted ;
        cell.deleteBtn.tag=indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    //
    if (self.indexPath.row==1)
    {
        static NSString * cellIdentifier=@"cell";
        jobApplyCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[jobApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        cell.jobName.text=[((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title removeSpaceAndEnter:((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title];
        cell.companyName.text=[((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name];
        
        cell.date.text=((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).date_applied ;
        
        NSMutableString * str=[NSMutableString stringWithString:@"已申请"];
        [str appendString:[((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).applied_count removeSpaceAndEnter:((JobApplyRecord*)[self.jobApplyArr objectAtIndex:indexPath.row]).applied_count]];
        [str appendString:@"人"];
        cell.applyNum.text=str;
       
        return cell;
    }
    
    //
    if (self.indexPath.row==2&&wheatherDelete==YES) {
       
        static NSString * cellIdentifier=@"cell";
        favJobCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[favJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.jobName.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title];
            cell.companyName.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name];
            cell.address.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_city removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_city];
            cell.chooseImg.tag=indexPath.row;
            [cell.chooseImg addTarget:self action:@selector(saveHasImageCell:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if ([chooseJobBack containsObject:indexPath])
            {
                [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:UIControlStateNormal];
            }
            
            
            else
            {
                [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected"] forState:UIControlStateNormal];
            }

            
        }
        return cell;
    }
    if (self.indexPath.row==2&&wheatherDelete==NO) {
        
        static NSString * cellIdentifier1=@"cell1";
        favJobDeleteCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell) {
            cell=[[[favJobDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
            cell.jobName.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_title];
            cell.companyName.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name];
            cell.address.text=[((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_city removeSpaceAndEnter:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_city];
            [cell.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.tag=indexPath.row;
            
        }
        return cell;
    }
    
    //
    if (self.indexPath.row==3&&self.myTableView.frame.origin.x==0&&wheatherDelete==YES) {
        
        static NSString * cellIdentifier=@"cell";
        JobSearchorCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[JobSearchorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [cell.lastestPositionNum setTitle:[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).today_update_job_count removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).today_update_job_count] forState:0];
       
        if ([[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval ] isEqualToString:@"0"]) {
            cell.takeDays.text=@"不订阅";
            [cell.takeDaysView addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
            [cell.lastestPositionNum addTarget:self action:@selector(getLastestJob:) forControlEvents:UIControlEventTouchUpInside];
            cell.lastestPositionNum.tag=indexPath.section;
            
        }
        else
        {
            NSMutableString * str=[NSMutableString stringWithString:@"订阅"];
            [str appendString:[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval ]];
            [str appendString:@"天"];
            
            cell.takeDays.text=str;
            [cell.takeDaysView addTarget:self action:@selector(modifyTakeDays:) forControlEvents:UIControlEventTouchUpInside];
            [cell.lastestPositionNum addTarget:self action:@selector(getLastestJob:) forControlEvents:UIControlEventTouchUpInside];
            cell.lastestPositionNum.tag=indexPath.section;
        }
        return cell;
}
    if (self.indexPath.row==3&&wheatherDelete==NO)
    {
        static NSString * cellIdentifier1=@"cell1";
        JobSearchorCell1 * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell) {
            cell=[[[JobSearchorCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
            
            [cell.lastestPositionNum setTitle:[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).today_update_job_count removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).today_update_job_count] forState:0];
            
            if ([[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval ] isEqualToString:@"0"]) {
                cell.takeDays.text=@"不订阅";
                
            }
            else
            {
                NSMutableString * str=[NSMutableString stringWithString:@"订阅"];
                [str appendString:[((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:indexPath.section]).send_interval ]];
                [str appendString:@"天"];
                
                cell.takeDays.text=str;
                
            }
            cell.deleteBtn.tag=indexPath.section;
            [cell.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
  
   return nil;

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.indexPath.row==3&&[self.searchArr count]!=0) {
        UILabel * label=[[[UILabel alloc] init] autorelease];
        
        jobSearchEntity * data=[self.searchArr objectAtIndex:section];
//        NSLog(@"%@",data.alert_name);
        NSMutableString * str=[NSMutableString stringWithString:@"   "];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor whiteColor];
        [str appendString:[data.alert_name removeSpaceAndEnter:data.alert_name]];
        label.text=str;
        label.font=[UIFont fontWithName:@"Arial" size:16];
        return label;
    }
        else
        {
            return nil;
        
        }
}
   
    
    


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indexPath.row==3) {
        return 50;
    }
    return 50;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indexPath.row==0) {
        MailContentViewController * root=[[MailContentViewController alloc] init];
        root.email_number=((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).email_number;
        root.Company_name=((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).company_name;
        root.Is_read=((managerOfferEntity *)[self.jobApplyArr objectAtIndex:indexPath.row]).is_read;
        root.uticket=self.search;
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }
    
    if (self.indexPath.row==1) {
        CompanyDetailInfoViewController * root=[[CompanyDetailInfoViewController alloc] init];
        root.identifier=@"2";
        root.Job_number=[((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number
                         removeSpaceAndEnter:((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number ];
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }
    
    if (self.indexPath.row==2) {
        CompanyDetailInfoViewController * root=[[CompanyDetailInfoViewController alloc] init];
        root.identifier=@"3";
        root.Job_number=[((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number
                         removeSpaceAndEnter:((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number ];
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }
    
    if (self.indexPath.row==3) {
        CompanyDetailInfoViewController * root=[[CompanyDetailInfoViewController alloc] init];
        root.identifier=@"4";
        root.Job_number=[((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number
                         removeSpaceAndEnter:((JobApplyRecord *)[self.jobApplyArr objectAtIndex:indexPath.row]).job_number ];
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }



}
#pragma mark -selffunc-
-(void)back:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)edit:(UIButton *)sender
{
    
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        wheatherDelete=NO;
        [self.myTableView reloadData];
       
        [sender setTitle:@"完成" forState:0];
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"完成"]) {
        wheatherDelete=YES;
        [self.myTableView reloadData];
        [sender setTitle:@"编辑" forState:0];
         return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"申请"]) {
        UIAlertView * apply=[[UIAlertView alloc] initWithTitle:nil message:@"职位申请成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [apply show];
        [apply release];
        return;
    }
}

-(void)click:(UITapGestureRecognizer *)sender
{
    CreatJobSearchorViewController * root=[[CreatJobSearchorViewController alloc] init];
    [self.navigationController pushViewController:root animated:YES];
    [root release];
}

-(void)delete:(UIButton *)sender
{
    //
    if (self.indexPath.row==3) {
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        [dic setObject:((jobSearchEntity *)[self.searchArr objectAtIndex:sender.tag]).alert_id forKey:@"Alert_id"];
        [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
        RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobsearcher_del.aspx" withHttpMethod:@"GET" withParams:dic];
        [data setResultData:^(id aid, NSError *error) {
//            NSLog(@"%@",aid);
            if ([((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"])removeSpaceAndEnter:((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]) ]!=@"0") {
                [self.searchArr removeObjectAtIndex:sender.tag];
                [self.myTableView reloadData];
                
            }
            else
            {
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"删除职位搜索器出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
        }];
        [data connect];

    }
    
 //
    
    if (self.indexPath.row==2) {
//        NSLog(@"%d",sender.tag);
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        [dic setObject:((jobCollectionEntity *)[self.jobApplyArr objectAtIndex:sender.tag]).job_number forKey:@"Job_number"];
        [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
        RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_del.aspx" withHttpMethod:@"GET" withParams:dic];
        [data setResultData:^(id aid, NSError *error) {
//            NSLog(@"%@",aid);
            if ([((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"])removeSpaceAndEnter:((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]) ]!=@"0") {
                [self.jobApplyArr removeObjectAtIndex:sender.tag];
                [self.myTableView reloadData];
                
            }
            else
            {
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"删除职位收藏记录出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
        }];
        [data connect];
    }
    
    if (self.indexPath.row==0) {
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        [dic setObject:((managerOfferEntity *)[self.jobApplyArr objectAtIndex:sender.tag]).email_number forKey:@"email_number"];
        [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"uticket"];
        RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_mail_del.aspx" withHttpMethod:@"GET" withParams:dic];
        [data setResultData:^(id aid, NSError *error) {
//            NSLog(@"%@",aid);
            if ([[((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"])removeSpaceAndEnter:((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]) ] integerValue]!=0) {
//                NSLog(@"%@",[((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"])removeSpaceAndEnter:((NSString *)[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]) ]);
                [self.jobApplyArr removeObjectAtIndex:sender.tag];
                [self.myTableView reloadData];
                
            }
            else
            {
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"删除失败,错误原因" message:@"服务器发生异常"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
        }];
        [data connect];

    }

}
#pragma mark -cellButtonFunc-
-(void)modifyTakeDays:(UIButton *)sender
{

    self.myActionSheet = [[[UIActionSheet alloc]initWithTitle:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"cancel"
                                      destructiveButtonTitle:@"OK"
                                           otherButtonTitles:@"1",@"2", nil] autorelease];
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    NSMutableArray * barsArray = [NSMutableArray array];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barsArray addObject:spaceItem];
    [spaceItem release];
    
    UIBarButtonItem *twoItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pickerBarButton:)];
    twoItem.tag=sender.tag;
    [barsArray addObject:twoItem];
    [twoItem release];
    
    toolBar.items = barsArray;
    
    //加载拾取器：
    takeDaysView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 220)];
    self.shouldGroupAccessibilityChildren = YES;
    takeDaysView.delegate = self;
    takeDaysView.dataSource = self;
    takeDaysView.showsSelectionIndicator = YES;
    [self.myActionSheet addSubview:takeDaysView];
    [takeDaysView release];
    [self.myActionSheet addSubview:toolBar];
    [toolBar release];
    [self.myActionSheet showInView:self.view];
    


}

#pragma mark -uipickViewDelegate-
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [takeDaysArr count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [takeDaysArr objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [wheatherFirstPickArr addObject:[NSNumber numberWithInt:row]];
  
    //对订阅天数进行处理
    self.takeDayasStr=[takeDaysArr objectAtIndex:row];
    if ([[takeDaysArr objectAtIndex:row] isEqualToString:@"不订阅"]) {
        self.takeDayasStr=@"0";
    }
    else
    {
        NSRange p=NSMakeRange(2, 1);
        self.takeDayasStr=[[takeDaysArr objectAtIndex:row] substringWithRange:p];
    
    }

}

//点击完成，完成ui的修改
-(void)pickerBarButton:(UIBarButtonItem *)sender
{
    if ([wheatherFirstPickArr count]==0) {
         [self.myActionSheet dismissWithClickedButtonIndex:1 animated:YES];
        return;
    }
    //修改ui
    [self.myActionSheet dismissWithClickedButtonIndex:1 animated:YES];
    jobSearchEntity * data=[self.searchArr objectAtIndex:sender.tag];
    data.send_interval=self.takeDayasStr;
    [self.myTableView reloadData];
    
    //网络请求，修改订阅频率,修改数据
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    [dic setObject:((jobSearchEntity *)[self.searchArr objectAtIndex:sender.tag]).alert_id forKey:@"Alert_id"];
    [dic setObject:self.takeDayasStr forKey:@"Send_interval"];
    [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
    RequestData * takeDaysData=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobsearcher_set_interval.aspx" withHttpMethod:@"GET" withParams:dic];
    [takeDaysData setResultData:^(id aid, NSError *error) {
//        NSLog(@"%@",aid);
        
    }];
    [takeDaysData connect];
    
}

//查看最新职位
-(void)getLastestJob:(UIButton *)sender
{
    //网络请求，获取最新职位
    //网络请求，修改订阅频率,修改数据
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    [dic setObject:((jobSearchEntity *)[self.searchArr objectAtIndex:sender.tag]).alert_id forKey:@"Alert_id"];
    [dic setObject:@"25" forKey:@"Pagesize"];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"1" forKey:@"Publishdate"];
    [dic setObject:[self.search removeSpaceAndEnter:self.search] forKey:@"Uticket"];
    ZhiLianManager * manager=[[ZhiLianManager alloc] init];
    [manager setfinishBlock:^(id result, id result1, id result2) {
       [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        getLastestTransferArr=result;
     
//        NSLog(@"%@",getLastestTransferArr);
        //push
        LasteastJobViewController * root=[[LasteastJobViewController alloc] init];
        root.titleName=[((jobSearchEntity *)[self.searchArr objectAtIndex:sender.tag]).alert_name removeSpaceAndEnter:((jobSearchEntity *)[self.searchArr objectAtIndex:sender.tag]).alert_name];
        root.dataArr=getLastestTransferArr;
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }];
    [manager getLastestJobWithURL:@"http://wapinterface.zhaopin.com/iphone/job/searchjobs.aspx" withHttpMethod:@"GET" withParams:dic];
    [manager release];
}

-(void)saveHasImageCell:(UIButton *)sender
{
    if (![chooseJobBack containsObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
        [chooseJobBack addObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
//        NSLog(@"%@",chooseJobBack);
        [edit setTitle:@"申请" forState:0];
        
        
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [chooseJobBack removeObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        if ([chooseJobBack count]==0) {
             [edit setTitle:@"编辑" forState:0];
        }
    
        
    }
    
    
}

//程序加载画面
-(void)loadPic
{
    //程序加载画面
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    load=[[UIView alloc] initWithFrame:self.view.bounds];
    load.alpha=0.5;
    load.backgroundColor=[UIColor blackColor];
    [self.view addSubview:load];
    [load release];
    
    UIActivityIndicatorView * aView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
   
    aView.frame=CGRectMake(0, 0, 50, 50);
    aView.center=CGPointMake(self.view.center.x, self.view.center.y-50);
//  self.view.center;
    [aView  startAnimating];
    [load addSubview:aView];
    [aView release];
    
    UILabel * bView=[[UILabel alloc] initWithFrame:CGRectMake(aView.frame.origin.x-10, aView.frame.origin.y+50, 70, 20)];
    bView.textAlignment=NSTextAlignmentCenter;
    bView.backgroundColor=[UIColor clearColor];
    bView.text=@"加载中...";
    [load addSubview:bView];
    [bView release];
}

-(void)hiddenLoad
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [load removeFromSuperview];
}

@end
