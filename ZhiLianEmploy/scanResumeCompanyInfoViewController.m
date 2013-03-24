//
//  scanResumeCompanyInfoViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-1.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "scanResumeCompanyInfoViewController.h"
#import "RequestData.h"
#import "ZhiLianManager.h"
#import "scanResumeCompanyListEntity.h"
#import "NSString+removeSaceAndEnter.h"
#import "scanResumeCompanyListCell.h"
#import "CompanyDetailInfoViewController.h"

@interface scanResumeCompanyInfoViewController ()

@end

@implementation scanResumeCompanyInfoViewController

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
    self.title=@"浏览";
    
    self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44)] autorelease];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
    
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    [dic setObject:self.search forKey:@"uticket"];
    [dic setObject:@"1" forKey:@"Page"];
    [dic setObject:self.pageSize forKey:@"Pagesize"];
    
    ZhiLianManager * manager=[[ZhiLianManager alloc] init];
    [manager setfinishBlock:^(id result, id result1, id result2) {
        self.dataArr=result;
        [self.myTableView reloadData];
        
    }];
    [manager getScanResumeCompanyListWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/getcompanylist_showresume.aspx" withHttpMethod:@"GET" withParams:dic];
    [manager release];
    
//    RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/getcompanylist_showresume.aspx" withHttpMethod:@"GET" withParams:dic];
//    [data setResultData:^(id aid, NSError *error) {
//        NSLog(@"%@",aid);
//    }];
//    [data connect];
    
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
#pragma mark -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"cell";
    scanResumeCompanyListCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil==cell) {
        cell=[[[scanResumeCompanyListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.companyName.text=[((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_name removeSpaceAndEnter:((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_name ];
    cell.scale.text=[((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_size removeSpaceAndEnter:((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_size ];
    cell.date.text=[((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).date_show removeSpaceAndEnter:((scanResumeCompanyListEntity *)[self.dataArr objectAtIndex:indexPath.row]).date_show ];
   
    return cell;



}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyDetailInfoViewController * root=[[CompanyDetailInfoViewController alloc] init];
    root.identifier=@"1";
    [self.navigationController pushViewController:root animated:YES];
    [root release];

}
#pragma mark -selffuc-
-(void)back:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}

@end
