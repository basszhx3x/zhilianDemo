//
//  LoginOutViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "LoginOutViewController.h"
#import "loginOutCell.h"

@interface LoginOutViewController ()

@end

@implementation LoginOutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imgArr=[[NSArray alloc] initWithObjects:@"unreader@2x.png",@"favorite@2x.png",@"job_record@2x.png",@"searchSubscribeViewController@2x.png" ,nil];
        titleArr=[[NSArray alloc] initWithObjects:@"人事经理来信",@"职位申请记录",@"职位收藏夹",@"搜索与订阅", nil];
    }
    return self;
}

-(void)dealloc
{
    [_myTableView release];
    [imgArr release];
    [titleArr release];
    [super dealloc];

}

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)]autorelease];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    
    self.title = @"我的智联";
    
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(loginOut:)] autorelease];
    
    self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped] autorelease];
//    CGRectMake(0, 180, 320, 300)
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
   
    
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 static NSString * cellIdentifier=@"cell";
    loginOutCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil==cell) {
        cell=[[[loginOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
        cell.title.text=[titleArr objectAtIndex:indexPath.row];
        cell.info.text=@"123";
        return cell;
    }
    return cell;
}

#pragma mark -selffunc
-(void)loginOut
{


}

@end
