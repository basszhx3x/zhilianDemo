//
//  SearchDetailConditionViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SearchDetailConditionViewController.h"
#import "BaseData.h"
#import "ASearchJobCell.h"
#import "NSString+removeSaceAndEnter.h"
#import "MoreDetailConditionViewController.h"

@interface SearchDetailConditionViewController ()

@end

@implementation SearchDetailConditionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        chooseJobDataArr=[[NSMutableArray alloc] init];
        chooseJobBack=[[NSMutableArray alloc] init];
        
        chooseArea=[[NSMutableArray alloc] init];
        self.indexPathDic=[[[NSMutableDictionary alloc] init] autorelease];
      
    }
    return self;
}

-(void)dealloc
{
    [chooseJobDataArr release];
    [chooseJobBack release];
    [chooseArea release];
    [_myTableView release];
    [_myScrollView release];
    [_indexpath release];
    [super dealloc];
}

-(void)loadView
{
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
//    NSLog(@"%@",self.indexPathDic);
    if ([self.indexPathDic objectForKey:self.indexpath]!=nil)
    {
        //数组这样赋值不会被自动释放，chooseJobBack最好声明成属性，否则有可能造成内存孤岛
        chooseJobBack=[self.indexPathDic objectForKey:self.indexpath];
        [chooseJobBack  retain];
    }
    
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 50, 30);
    [back setTitle:@"返回" forState:0];
    [back setTitleColor:[UIColor whiteColor] forState:0];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:back] autorelease];
    
    self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44)] autorelease];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    [self.view addSubview:self.myTableView];

    if (self.indexpath.row==0)
    {
       
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getPositionName];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
             NSString * str1=[arr objectAtIndex:0];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
            [chooseArea addObject:str1];
        }
        
        self.title=@"选择职业";
        return;
}
    if (self.indexpath.row==1) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getIndustryCategory];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择行业";
       
    }
    if (self.indexpath.row==2) {
       
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getArea];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            NSString * str1=[arr objectAtIndex:0];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
            [chooseArea addObject:str1];
        }
      
        self.title=@"选择地区";
        }
    if (self.indexpath.row==4) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getPublishDate];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择发布时间";
    }
    if (self.indexpath.row==5) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getWorkExperience];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择工作经验";
    }
    if (self.indexpath.row==6) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getEducationBackground];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择学历要求";
    }
    if (self.indexpath.row==7) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getCompanyType];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择工作性质";
    }
    if (self.indexpath.row==8) {
        BaseData * data=[BaseData getInstance];
        chooseJobArr=[data getCompanySize];
        for (NSArray* arr in chooseJobArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [chooseJobDataArr addObject:[str removeSpaceAndEnter:str]];
        }

        self.title=@"选择公司规模";
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

#pragma mark -tableViewFunc
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [chooseJobDataArr count];
}

//处理技巧
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //把static去掉就不重用了
//    NSString * cellIdentifier=[NSString stringWithFormat:@"%@=%d",@"cell",indexPath.row];
    if (self.indexpath.row==0||self.indexpath.row==2) {
        static NSString * cellIdentifier=@"cell";
        ASearchJobCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[ASearchJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [cell.headImg addTarget:self action:@selector(saveHasImageCell:) forControlEvents:UIControlEventTouchUpInside];
        cell.headImg.tag=indexPath.row;
        
     
        
        if ([chooseJobBack containsObject:indexPath])
        {
            [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:UIControlStateNormal];
        }
        
    
        else
        {
            [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected"] forState:UIControlStateNormal];
        }
        
        cell.titleLabel.text=[chooseJobDataArr objectAtIndex:indexPath.row];
        return cell;

    }
    if (self.indexpath.row==4)
    {
        static NSString * cellIdentifier1=@"cell1";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell) {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        
        cell.textLabel.text=[chooseJobDataArr objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont fontWithName:@"Arial" size:14];
        return cell;
    
    }
        
        
        static NSString * cellIdentifier=@"cell";
        ASearchJobCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[ASearchJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [cell.headImg addTarget:self action:@selector(saveHasImageCell:) forControlEvents:UIControlEventTouchUpInside];
        cell.headImg.tag=indexPath.row;
      
        if ([chooseJobBack containsObject:indexPath])
        {
            [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected"] forState:UIControlStateNormal];
        }
        
        cell.titleLabel.text=[chooseJobDataArr objectAtIndex:indexPath.row];
        cell.accessoryImg.hidden=YES;
        return cell;

    
   
   }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indexpath.row==0||self.indexpath.row==2) {
        MoreDetailConditionViewController * root=[[MoreDetailConditionViewController alloc] init];
        root.indexpath=self.indexpath;
        if ([chooseJobBack containsObject:indexPath]) {
            root.identifier1=@"1";
        }
        root.identifier=[chooseArea objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:root animated:YES];
        [root release];
    }
    if (self.indexpath.row==4) {
        
        //传值，通过字典将indexpath传过去，然后再传回来，判断那个打钩了
        UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        [dic setObject:indexPath forKey:self.indexpath];
        [self.delegate transferSearchJobCondition:self withCondition:cell.textLabel.text withIndexpath:self.indexpath withNsdictionary:dic];
        NSArray * arr=self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arr objectAtIndex:2] animated:YES];
    }

}

#pragma mark -selffuc-
-(void)back:(UIButton *)sender
{
    if (self.indexpath.row!=4) {
        //设置返回数据
        NSMutableString * backStr=[NSMutableString string];
        for (int i=0; i<[chooseJobBack count]; i++) {
            if (i<[chooseJobBack count]-1) {
                ASearchJobCell * cell=(ASearchJobCell *)[self.myTableView cellForRowAtIndexPath:[chooseJobBack objectAtIndex:i]];
                [backStr appendString:cell.titleLabel.text];
                [backStr appendString:@";"];
            }
            if (i==[chooseJobBack count]-1) {
                ASearchJobCell * cell=(ASearchJobCell *)[self.myTableView cellForRowAtIndexPath:[chooseJobBack objectAtIndex:i]];
                [backStr appendString:cell.titleLabel.text];
            }
        }
        
        //传值，通过字典将indexpath传过去，然后再传回来，判断那个打钩了
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
//        NSLog(@"%@",chooseJobBack);
        [dic setObject:chooseJobBack forKey:self.indexpath];
        
        [self.delegate transferSearchJobCondition:self withCondition:backStr withIndexpath:self.indexpath withNsdictionary:dic];
        
        //清空数据源，进行下一个数据存储
        [chooseJobDataArr removeAllObjects];
        NSArray * arr=self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arr objectAtIndex:2] animated:YES];
}
    
    else
    {
        NSArray * arr=self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arr objectAtIndex:2] animated:YES];
    }
}

-(void)saveHasImageCell:(UIButton *)sender
{
    if (![chooseJobBack containsObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
        [chooseJobBack addObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
//        NSLog(@"%@",chooseJobBack);
        
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [chooseJobBack removeObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];

    }
}
@end
