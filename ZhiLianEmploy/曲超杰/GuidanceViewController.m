//
//  GuidanceViewController.m
//  ZhiLianLQX
//
//  Created by Ibokan on 13-2-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "GuidanceViewController.h"
#import "ForPageCell.h"
#import "RequestData.h"
#import "ChangeJobViewController.h"
#import "EndPushViewController.h"
#import "TitlePushTabViewController.h"

@interface GuidanceViewController ()

@end

@implementation GuidanceViewController

- (void)dealloc
{
    [_array release];
    [_NameArr release];
    [_TitleArr release];

    [_contentArr release];
    [_IDArray release];
    [_IDdicText release];
    [_IDTitSectionArr release];
    [_IDChannelArr release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
//        NSMutableArray *array = [NSMutableArray array];
//        [array retain];
        self.NameArr = [NSMutableArray array];
        
        self.TitleArr = [NSMutableArray array];
        
        self.contentArr = [NSMutableArray array];
        
        self.IDArray = [NSMutableArray array];
        
        self.IDdicText = [NSMutableDictionary dictionary];
        
        self.IDTitSectionArr = [NSMutableArray array];
        
        self.IDChannelArr = [NSMutableArray array];
    }
    return self;
}
-(void)loadView
{    
    self.array = [NSMutableArray arrayWithObjects:@"网申",@"职场健康",@"毕业生",@"职场聚焦",@"简历",@"职业规划",@"薪酬",@"面试", nil];
   
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)]autorelease];

    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];

    self.title = @"求职指导";
           
    [self JieShouData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
//    NSLog(@"%d",self.NameArr.count);

    return self.NameArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
//    NSLog(@"%d",section);
    UIView *HeaderView = [[[UIView alloc] initWithFrame:CGRectMake(5, 6, 310, 40)] autorelease];

    UILabel *firstLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 2, 100, 35)] autorelease];
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.text = [self.NameArr objectAtIndex:section];
    firstLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [firstLabel setTextColor:[UIColor whiteColor]];
    [HeaderView addSubview:firstLabel];    
    
    UIButton *RightButten = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [RightButten setBackgroundImage:[UIImage imageNamed:@"loginPress"] forState:(UIControlStateNormal)];
    [RightButten setBackgroundImage:[UIImage imageNamed:@"loginNormal"] forState:(UIControlStateSelected)];
    RightButten.frame = CGRectMake(320-80, 5, 50 , 22);
    
    RightButten.tag=1000+1000*section;
    
    [RightButten setTitle:@"更多" forState:(UIControlStateNormal)];
    RightButten.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
//    
    [RightButten addTarget:self
                    action:@selector(TitlePushAction:)
          forControlEvents:(UIControlEventTouchUpInside)];
    
    [HeaderView addSubview:RightButten];
  
    return HeaderView;
    
}

-(void)TitlePushAction:(UIButton *)sender
{
//    NSLog(@"%d",sender.tag);
    
//    NSLog(@"%@",self.PushSection);
    TitlePushTabViewController *titlePushTitle =[[TitlePushTabViewController alloc] init];
    titlePushTitle.IDTitleArr = self.NameArr;
    titlePushTitle.section = self.PushSection;
    titlePushTitle.pushTag = sender.tag;
//    NSLog(@"%@",self.IDTitSectionArr);
    titlePushTitle.IDChannelPushArr = self.IDChannelArr;
//    NSLog(@"%@",titlePushTitle.IDChannelPushArr);
    [self.navigationController pushViewController:titlePushTitle animated:YES];
    [titlePushTitle release];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ForPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[ForPageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
        self.PushSection = indexPath;
    }

    cell.CellLabel.text = [[self.contentArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.CellLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    EndPushViewController *ChangejobVC = [[EndPushViewController alloc] init];
    ChangejobVC.IDdicArr = self.IDArray;
//    NSLog(@"%@",self.IDArray);
    ChangejobVC.EndIndexPath = indexPath;
//    NSLog(@"%@",ChangejobVC.IDdicArr);
    [self.navigationController pushViewController:ChangejobVC animated:YES];
    [ChangejobVC release];
}

#pragma <JieShouData-------------------------------->

-(void)JieShouData
{

    RequestData *ReqData = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/article/channellist.service"
                                                withHttpMethod:nil
                                                withParams:nil];
    [ReqData setResultData:^(id aid, NSError *error)
     {
        NSMutableDictionary *dic = [aid valueForKey:@"root"];;
         NSMutableArray *arr = [dic valueForKey:@"channel"];

//         NSLog(@"%@",aid);
//         dic 
//         NSLog(@"11111%@",dic);
//         arr ;
//         NSLog(@"2222%@",arr);
         for (NSMutableDictionary *AllDic in arr)
         {
             NSMutableDictionary *dic1 =  [AllDic valueForKey:@"articles"];
//             NSLog(@"3333 %@",dic1);
             NSMutableDictionary *nameDic =  [AllDic valueForKey:@"name"];
//             NSLog(@"name---------------->%@",nameDic);
             NSMutableArray *secarr = [dic1 valueForKey:@"article"];
//             NSLog(@"4444 %@",secarr);
             NSMutableArray *arrindex = [NSMutableArray array];
             NSMutableArray *arrIndexDic = [NSMutableArray array];
             for (NSMutableDictionary *Enddic in secarr)
             {
                  
                
                 NSMutableDictionary * IDdic = [Enddic valueForKey:@"id"];
                 NSMutableDictionary *Titeldic  = [Enddic valueForKey:@"title"];; 
                 
                 NSString *IDdicText1 = [IDdic valueForKey:@"text"];
//                 NSLog(@"<id------------------>%@",IDdicText1);
                 
                 NSMutableDictionary *IDTextDic = [NSMutableDictionary dictionary]; 
                 [IDTextDic setObject:IDdicText1 forKey:@"id"];
                 
//                 NSLog(@"<Titel--------------->%@",Titeldic);
                 
                 
                 NSString *TiteldicText = [Titeldic valueForKey:@"text"];
//                 NSLog(@"<id------------------>%@",TiteldicText);
          
                 [arrindex addObject:TiteldicText];
                 
                 [arrIndexDic addObject:IDTextDic];

//                 NSLog(@"%d",self.TitleArr.count);

                 
             }
             [self.IDArray addObject:arrIndexDic];
//             NSLog(@"%@",self.IDArray);

            
            int IDs = [[AllDic valueForKey:@"id"] integerValue];
//             NSLog(@"IDs------------>%d",IDs);
             
             NSMutableDictionary *dicID = [NSMutableDictionary dictionary];
           [dicID setObject:[NSString stringWithFormat:@"%d",IDs] forKey:@"cid"];
             [self.IDChannelArr addObject:dicID];
             [self.contentArr addObject:arrindex];
             NSString *NameDicText = [nameDic valueForKey:@"text"];
             [self.IDTitSectionArr addObject:NameDicText];
             [self.NameArr addObject:NameDicText]; 
         }
         [self.PageTableView reloadData];
     }];
    [ReqData connect];
}





- (void)viewDidLoad
{
//    NSLog(@"%d",self.NameArr.count);
    
    self.PageTableView = [[[UITableView alloc] initWithFrame:CGRectMake(5, 0, 310, 390) style:(UITableViewStyleGrouped)] autorelease];
    self.PageTableView.backgroundView.alpha = 0.0f;
    self.PageTableView.dataSource = self;
    self.PageTableView.delegate = self;
    [self.view addSubview:self.PageTableView];
    

    
    
    [super viewDidLoad];
    
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
