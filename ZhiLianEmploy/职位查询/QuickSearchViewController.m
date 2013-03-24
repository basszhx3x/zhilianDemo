//
//  QuickSearchViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "QuickSearchViewController.h"
#import "ChangeActionView.h"
#import "MyHistoryView.h"
#import "ChangeCell.h"
#import "ChangeJobViewController.h"
#import "ChangeVocationViewController.h"
#import "ChangeAreaViewController.h"
#import "PushHistoryViewController.h"
#import "TextfieldCell.h"
#import "RequestData.h"
#import "ChangeSearchViewController.h"


@interface QuickSearchViewController ()


@end
static int i;

@implementation QuickSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        i = 1;
        // Custom initialization
        self.PageDic = [NSMutableDictionary dictionary];

        self.TitelArray = [NSMutableArray array];

        self.LinerArray = [NSMutableArray array];

        self.SecLinerArray = [NSMutableArray array];

        self.subTitleArray=[[NSMutableArray alloc] initWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"",@"不选择", nil];
        self.CellArray = [NSMutableArray array];

        self.CellArrayEnd = [NSMutableArray array];

        self.subCellArray = [NSMutableArray array];

        self.subMinArray = [NSMutableArray array];

        self.Popstr = [NSMutableString string];

        self.indexpaths = [[NSIndexPath alloc] init];
        self.SalaryStr = [NSString string];

        self.ComSizeStr = [NSString string];

        self.changeCells = [[ChangeCell alloc] init];
        
        self.SearchDic = [NSMutableDictionary dictionary];
        

    }
    return self;
}

-(void)dealloc
{
    [_SearchDic release];
    [_changeCells release];
    [_ComSizeStr release];
    [_SalaryStr release];
    [_indexpaths release];
    [_subMinArray release];
    [_subCellArray release];
    [_CellArray release];
    [_CellArrayEnd release];
    [_butn release];
    [_TitelArray release];
    [_SecLinerArray release];
    [_PageDic release];
    [_SecLinerArray release];
    [_PageTableView release];
    [_subTitleArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DelegateName" object:nil];
    
    [super dealloc];

}

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    
    self.title = @"快速搜索";
    
    
    self.CellArray = [NSMutableArray arrayWithObjects:@"当前位置:",@"职位名称:",@"行业类别:",@"工作地点:",@"关键字:",@"定位范围:", nil];
    self.CellArrayEnd = [NSMutableArray arrayWithObjects:@"当前位置:",@"职位名称:",@"行业类别:",@"工作地点:",@"关键字:",@"发布时间:",@"工作经验:",@"学历要求:",@"公司性质:",@"公司规模:",@"月薪范围:",@"定位范围:", nil];
    self.CellArrayMid = self.CellArray;
    self.subCellArray = [NSMutableArray arrayWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"",@"请选择发布时间",@"请选择工作经验",@"请选择学历要求",@"请选择公司性质",@"请选择公司规模",@"不选择",@"不选择", nil];
    self.subMinArray = self.subTitleArray;
    
    self.LinerArray = [NSMutableArray arrayWithObjects:@"1", @"1",@"1",@"1",@"1",@"1",nil];
    self.SecLinerArray = [NSMutableArray arrayWithObjects: @"请选择职位名称+请选择行业+请选择...",nil];
    self.PageDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.SecLinerArray,@"  我的历史搜索   ",
                    self.CellArray, @"  选择职位搜索条件 ", nil];
    self.TitelArray = [NSMutableArray arrayWithArray:[self.PageDic allKeys]];
    
    self.PageTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:(UITableViewStyleGrouped)] autorelease];
    self.PageTableView.backgroundView.alpha = 0.0f;
    self.PageTableView.dataSource = self;
    self.PageTableView.delegate = self;
    self.PageTableView.userInteractionEnabled=YES;
    [self.view addSubview:self.PageTableView];
    
        
    NSNotificationCenter *centers =[NSNotificationCenter defaultCenter];
    [centers addObserver:self selector:@selector(userInfos:) name:@"DelegateName" object:nil];

}

-(void)userInfos:(NSNotification *)sender
{
//    NSLog(@"%@",[aInfo valueForKey:@"123"]);
    NSLog(@"123");
    NSLog(@"%@",sender.userInfo);
    [self.subTitleArray removeObjectAtIndex:3];
    [self.subTitleArray insertObject:[sender.userInfo valueForKey:@"123"] atIndex:3];
    [self.SearchDic setObject:sender forKey:@"city"];
    [self.PageTableView reloadData];
    
//    NSLog(@)
//        NSNotificationCenter *centers =[NSNotificationCenter defaultCenter];
//    NSLog(@"%@",centers.defaultCente.)
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSLog(@"%@",self.CellArray);
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"高级搜索"
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(changeliner_height)];

    self.navigationItem.rightBarButtonItem = barbtn;
    [barbtn release];

	// Do any additional setup after loading the view.

    
}
-(void)changeliner_height
{
    if (i%2 != 0) 
    {
        UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"快速搜索"
                                                                   style:(UIBarButtonItemStylePlain)
                                                                  target:self
                                                                  action:@selector(changeliner_height)];
        self.navigationItem.rightBarButtonItem = barbtn;
        self.CellArray = self.CellArrayEnd;
        self.PageDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.SecLinerArray,@"  我的历史搜索   ",
                        self.CellArrayEnd, @"  选择职位搜索条件 ", nil];
        self.subTitleArray = self.subCellArray;
        

    }
    else
    {
        UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"高级搜索"
                                                                   style:(UIBarButtonItemStylePlain)
                                                                  target:self
                                                                  action:@selector(changeliner_height)];
        self.navigationItem.rightBarButtonItem = barbtn;
        NSLog(@"123");
        self.CellArray = self.CellArrayMid;
        self.subTitleArray = self.subMinArray;
        self.PageDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.SecLinerArray,@"  我的历史搜索   ",
                        self.CellArray, @"  选择职位搜索条件 ", nil];        
    }
    [self.PageTableView reloadData];

    i++;
    

}


-(void)jieshouData
{
    [self.SearchDic setObject:@"fz" forKey:@"sort"];
    [self.SearchDic setObject:@"20" forKey:@"pagesize"];
    [self.SearchDic setObject:@"1" forKey:@"page"];
    NSLog(@"self.SearchDic-------------->%@",self.SearchDic);
    
    RequestData *reqData =[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx"
                                           withHttpMethod:@"GET"
                                               withParams:self.SearchDic];
    
    [reqData setResultData:^(id aid, NSError *error) {
        
        ChangeSearchViewController *csvc = [[ChangeSearchViewController alloc] init];
        csvc.rootDic = aid;
        [self.navigationController pushViewController:csvc animated:YES];
        if (error)
        {
           NSLog(@"%@", [error localizedDescription]);
        }
    }];
    [reqData connect];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return self.TitelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

    return [[self.PageDic objectForKey:[self.TitelArray objectAtIndex:section]] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

        UIView *views = [[[UIView alloc] initWithFrame:CGRectMake(5, 5, 150, 30)] autorelease];
        UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 30)] ;
        firstLabel.font=[UIFont fontWithName:@"Arial" size:16];
        firstLabel.backgroundColor = [UIColor clearColor];
        
        firstLabel.text = [self.TitelArray objectAtIndex:section];
        [firstLabel setTextColor:[UIColor whiteColor]];
        [views addSubview:firstLabel];
        [firstLabel release];
        return views;
        
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        UIView *view1 = [[UIView alloc] init];
        view1.frame = tableView.frame;
        UIButton * butn = [[UIButton buttonWithType:(UIButtonTypeCustom)] autorelease];
        butn.frame = CGRectMake((320-130)/2, 7, 136, 30);
        [butn setBackgroundImage:[UIImage imageNamed:@"searchbtn.png"] forState:0];
        [butn setTitle:@"查询" forState:0];
        [butn addTarget:self
                 action:@selector(jieshouData) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIImageView * gapLine=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 6+40, 320, 3)] autorelease];
        gapLine.image=[UIImage imageNamed: @"searchHistoryUpLine.png"];
//        gapLine.userInteractionEnabled=YES;
        [view1 addSubview:gapLine];

        [view1 addSubview:butn];
        
        

        return view1;
    }
    else
    {
        return 0;
    }
   

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    ChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[ChangeCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    if (indexPath.section == 0)
    {
        NSLog(@"%@",self.CellArray);
        
        cell.CellLabel.font=[UIFont fontWithName:@"Arial" size:14];
        cell.CellLabel.text = [self.CellArray objectAtIndex:indexPath.row];
        cell.subLabel.text=[self.subTitleArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 4)
        {
            static NSString *cells= @"cell1";
            TextfieldCell *cell1 = [[TextfieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cells];
            
            UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(310-200, 2, 180+10, 25)];
            textField1.backgroundColor=[UIColor whiteColor];
            textField1.placeholder=@"请点击输入";
            textField1.font=[UIFont fontWithName:@"Arial" size:14];
            textField1.delegate=self;
            [textField1  setTextAlignment:NSTextAlignmentRight];
            textField1.borderStyle = UITextBorderStyleRoundedRect;
            [cell1 addSubview:textField1];
            cell1.CellLabel.font=[UIFont fontWithName:@"Arial" size:14];
            cell1.CellLabel.text = [self.CellArrayEnd objectAtIndex:indexPath.row];
             
            return cell1;
            
            
        }
        
      
    }
    
  if (indexPath.section == 1) 
  {
      static NSString *cells= @"SectionCell";
      UITableViewCell *SectionCells = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cells];
      
      NSLog(@"%@",[self.CellArray objectAtIndex:indexPath.row]);
      SectionCells.textLabel.text=[self.SecLinerArray objectAtIndex:indexPath.row];
      SectionCells.textLabel.backgroundColor=[UIColor clearColor];
      SectionCells.textLabel.font=[UIFont fontWithName:@"Arial" size:12];
      SectionCells.detailTextLabel.text=@"无新增职位";
      SectionCells.detailTextLabel.font=[UIFont fontWithName:@"Arial" size:12];
      SectionCells.detailTextLabel.textAlignment=NSTextAlignmentRight;
      SectionCells.detailTextLabel.backgroundColor=[UIColor clearColor];
//      SectionCells.textLabel.text = [self.CellArrayEnd objectAtIndex:indexPath.section];
      
      
      
        return SectionCells;
 }

    
   
    return cell;
    
}


#pragma mark -returnPush QuickSearchViewController-

-(void)SalaryViewController:(SalaryViewController *)svc string:(NSString *)str
{
    self.SalaryStr = str;

    
    [self.subTitleArray removeObjectAtIndex:10];
    [self.subTitleArray insertObject:str atIndex:10];
    
    if ([str isEqualToString:@"1000元/月以下"])
    {
        [self.SearchDic setObject:@"0" forKey:@"salaryfrom"];
        [self.SearchDic setObject:@"1000" forKey:@"salaryto"];
        
    }
    else if([str isEqualToString:@"面议"])
    {
        return;
    }
    else if([str isEqualToString:@"不限"])
    {
        return;
    }
    else if([str isEqualToString:@"25000元/月以上"])
    {
        return;
    }

    else
    {
    NSArray *arr1 = [NSArray array];
    arr1 = [str componentsSeparatedByString:@"-"];
    NSLog(@"%@",arr1);
    NSArray *arr = [NSArray array];
    arr = [[arr1 objectAtIndex:1] componentsSeparatedByString:@"元"];
    
    
    [self.SearchDic setObject:[arr1 objectAtIndex:0] forKey:@"salaryfrom"];
    [self.SearchDic setObject:[arr objectAtIndex:0] forKey:@"salaryto"];
    }
        [self.PageTableView reloadData];

}
-(void)CompsizeViewController:(CompsizeViewController *)cVc compsizeArrStr:(NSString *)str
{
    self.ComSizeStr = str;
    [self.subTitleArray removeObjectAtIndex:9];
    [self.subTitleArray insertObject:str atIndex:9];
    [self.SearchDic setObject:str forKey:@"companysize"];
    [self.PageTableView reloadData];
}
-(void)CompTypeViewController:(CompTypeViewController *)ctvc CompTypeStr:(NSString *)str
{
    [self.subTitleArray removeObjectAtIndex:8];
    [self.subTitleArray insertObject:str atIndex:8];
    [self.SearchDic setObject:str forKey:@"companytype"];
    [self.PageTableView reloadData];
}
-(void)EducationViewController:(EducationViewController *)evc educationStr:(NSString *)str educationID:(NSString *)ID
{
    [self.subTitleArray removeObjectAtIndex:7];
    [self.subTitleArray insertObject:str atIndex:7];
    [self.SearchDic setObject:ID forKey:@"edu_level"];

    [self.PageTableView reloadData];
}
-(void)pushJobViewController:(PushJobViewController *)Pvc PushJobViewStr:(NSString *)str
{
    [self.subTitleArray removeObjectAtIndex:1];
    [self.subTitleArray insertObject:str atIndex:1];
    [self.SearchDic setObject:str forKey:@"schJobType"];

//    self.changeCells.textLabel.textColor = [UIColor blackColor];
//    NSLog(@"%@",self.changeCells.textLabel.textColor);
    [self.PageTableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.row == 1)
    {
        PushJobViewController *push = [[PushJobViewController alloc] init];
        ChangeJobViewController *ChangejobVC = [[ChangeJobViewController alloc] init];
        push.delegate = self;
        ChangejobVC.delegate1 = push.delegate;
        
        [self.navigationController pushViewController:ChangejobVC animated:YES];
    }
    else if(indexPath.row == 2)
    {
        ChangeVocationViewController *ChangeVocationVC = [[ChangeVocationViewController alloc] init];
        [ChangeVocationVC setStrBlock:^(NSString *str) {
            [self.subTitleArray removeObjectAtIndex:indexPath.row];
            [self.subTitleArray insertObject:str atIndex:indexPath.row];
            [self.SearchDic setObject:str forKey:@"industry"];
            
            [tableView reloadData];
        }];
        
        [self.navigationController pushViewController:ChangeVocationVC animated:YES];
    }
    else if(indexPath.row == 3)
    {
        ChangeAreaViewController *ChangeAreaVC = [[ChangeAreaViewController alloc] init];
        [self.navigationController pushViewController:ChangeAreaVC animated:YES];
    }
    else if(indexPath.row == 5 && i % 2 != 0)

    { 
            PicViewController *pushHVC = [[PicViewController alloc] init];
            [self.navigationController presentViewController:pushHVC animated:YES completion:^{
                nil;
            }];
            //         pushViewController:pushHVC animated:YES];
    }
    else if(i % 2 == 0)
    {
        if (indexPath.row == 11) 
        {
            PicViewController *pushHVC = [[PicViewController alloc] init];
            [self.navigationController presentViewController:pushHVC animated:YES completion:^{
                nil;
            }];
        }
        else if (indexPath.row == 5)
        {
            PublishTimeViewController *publishtimeVC = [[PublishTimeViewController alloc] init];

            [publishtimeVC setStrBlock:^(NSString *str,NSString *ID) {
                [self.subTitleArray removeObjectAtIndex:indexPath.row];
                [self.subTitleArray insertObject:str atIndex:indexPath.row];
                [self.SearchDic setObject:ID forKey:@"data_refresh"];
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:publishtimeVC animated:YES];
        }
        else if (indexPath.row == 6)
        {

            WorkEXPViewController *WorkEXPVC = [[WorkEXPViewController alloc] init];
            WorkEXPVC.indes = indexPath;
            
            [WorkEXPVC setStrBlock:^(NSString *str, NSIndexPath *indes)
             {

                 [self.subTitleArray removeObjectAtIndex:indes.row];
                 [self.subTitleArray insertObject:str atIndex:indes.row];
                 
                 [self.SearchDic setObject:str forKey:@"workingexp"];
                 
                 [tableView reloadData];
                 
             }];

            [self.navigationController pushViewController:WorkEXPVC animated:YES];
        }
        else if (indexPath.row == 7)
        {
            EducationViewController *EducationVC = [[EducationViewController alloc] init];
            EducationVC.delegate = self;
            [self.navigationController pushViewController:EducationVC animated:YES];
        }
        else if (indexPath.row == 8)
        {
            CompTypeViewController *CompTypeVC = [[CompTypeViewController alloc] init];
            CompTypeVC.delegate = self;
            [self.navigationController pushViewController:CompTypeVC animated:YES];
        }
        else if (indexPath.row == 9)
        {
            CompsizeViewController *CompSizeVC = [[CompsizeViewController alloc] init];
            CompSizeVC.delegate = self;
            [self.navigationController pushViewController:CompSizeVC animated:YES];
        }
        else if (indexPath.row == 10)
        {
            SalaryViewController *SalaryVC = [[SalaryViewController alloc] init];
            SalaryVC.delegate = self;
            [self.navigationController pushViewController:SalaryVC animated:YES];
        }
        else
{
    NSLog(@"[tablew seletion] error......");
}

        

        
    }

        
    else
    {
        return;
    }
    
    

    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return  YES;
}

#pragma mark -selffuc-
-(void)searchJob:(UIButton *)sender
{
    NSLog(@"123");

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.view viewWithTag:3000].hidden=NO;

    
}




@end
