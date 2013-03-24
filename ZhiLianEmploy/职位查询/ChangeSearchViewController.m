//
//  ChangeSearchViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-1.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ChangeSearchViewController.h"
#import "Decide.h"
#import "favJobCell.h"
#import "JobMessageViewController.h"
#import "newCell.h"
@interface ChangeSearchViewController ()

@end
static int itag;
static int i;
@implementation ChangeSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        itag = 1;
        i = 1;
        self.title = @"请选择职位搜索条件";
        
        self.rootDic = [NSDictionary dictionary];
        self.Allarr = [NSMutableArray array];
        self.tagarr = [NSMutableArray array];
        self.ChangeArr = [NSMutableArray array];        
        self.DelArr = [NSMutableArray array];
        self.jobNumberDic = [NSMutableDictionary dictionary];
        self.DicArr = [NSMutableArray array];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barbtnItem = [[UIBarButtonItem alloc] initWithTitle:@"申请"
                                                                   style:(UIBarButtonItemStylePlain)
                                                                  target:self
                                                                  action:@selector(shenqing)];
    self.navigationItem.rightBarButtonItem = barbtnItem;
    [barbtnItem release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self dataJieShou];
}

-(void)shenqing
{
    NSLog(@"%@",self.ChangeArr);
    if ([self.ChangeArr count]!=0)
    {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"请选择要投递的简历" message:nil delegate:nil cancelButtonTitle:@"放弃" otherButtonTitles:@"11", nil];
        [self.view addSubview:alerview];
        [alerview show];

    }
    else
    {
        return;
    }
    
    
}


-(void)dataJieShou
{
    NSLog(@"%@",self.rootDic);
    NSDictionary *resultDic = [NSMutableDictionary dictionary];
    if ([self.rootDic isKindOfClass:[NSMutableDictionary class]])
    {
        
        NSDictionary *dic = [self.rootDic valueForKey:@"root"];
        resultDic = [dic valueForKey:@"result"];
        NSLog(@"result-------->%@",resultDic);
        if ([[resultDic objectForKey:@"position"] isKindOfClass:[NSMutableDictionary class]]) 
        {
            NSDictionary *positonDic = [resultDic valueForKey:@"position"];
            NSLog(@"positonDic------->%@",positonDic);
            NSMutableDictionary *dics = [NSMutableDictionary dictionary];
            dics = [positonDic valueForKey:@"city_id"];
            NSString *dicStr = [dics valueForKey:@"text"];            
            
            NSMutableDictionary *d = [NSMutableDictionary dictionary];
            d = [positonDic valueForKey:@"job_number"];
            NSString *ds = nil;
            ds = [d valueForKey:@"text"];
            NSArray *dsarr = [ds componentsSeparatedByString:@" "];
            NSString *dsstrs = nil;
            dsstrs = [dsarr objectAtIndex:dsarr.count-1];
            [self.jobNumberDic setObject:dsstrs forKey:@"Job_number"];
            NSLog(@"%@",self.jobNumberDic);
//            self.jobNumberDic
            
            NSMutableDictionary *CompNamedic = [NSMutableDictionary dictionary];
            CompNamedic = [positonDic valueForKey:@"company_name"];
            NSString *CompNamedicS = [CompNamedic valueForKey:@"text"];
            NSArray *arrx = [CompNamedicS componentsSeparatedByString:@" "];
            NSString *CompNamedicStr = [arrx objectAtIndex:arrx.count-1];
            
            
            NSMutableDictionary *CompNumberDic = [NSMutableDictionary dictionary];
            CompNumberDic = [positonDic valueForKey:@"company_number"];
            NSString *CompNumberDicS = [CompNumberDic valueForKey:@"text"];
            NSArray *arrx1 = [CompNumberDicS componentsSeparatedByString:@" "];
            NSString *CompNumberDicStr = [arrx1 objectAtIndex:arrx1.count-1];
            
            NSMutableDictionary *job_titledic = [NSMutableDictionary dictionary];
            job_titledic = [positonDic valueForKey:@"job_title"];
            NSString *job_titledicS = [job_titledic valueForKey:@"text"];
            NSArray *arrx2 = [job_titledicS componentsSeparatedByString:@" "];
            
            NSString *job_titledicStr = [arrx2 objectAtIndex:arrx2.count-1];
            
            NSMutableDictionary *company_short_namedic = [NSMutableDictionary dictionary];
            company_short_namedic = [positonDic valueForKey:@"company_short_name"];
            NSString *company_short_namedicStr = [company_short_namedic valueForKey:@"text"];

            
            NSMutableArray * arr1 = [NSMutableArray arrayWithObjects:dicStr, CompNamedicStr, CompNumberDicStr, job_titledicStr , company_short_namedicStr, nil];
            [self.Allarr addObject:arr1];



        }
    
    else
    {
        
        NSMutableArray *positionArr = [NSMutableArray array];
        positionArr = [resultDic valueForKey:@"position"];
        NSLog(@"positionArr---------->%@",positionArr);
        
        for (NSMutableDictionary *dic in positionArr)
        {
            NSMutableDictionary *d = [NSMutableDictionary dictionary];
            d = [dic valueForKey:@"job_number"];
            NSString *ds = nil;
            ds = [d valueForKey:@"text"];
            NSArray *dsarr = [ds componentsSeparatedByString:@" "];
            NSString *dsstrs = nil;
            dsstrs = [dsarr objectAtIndex:dsarr.count-1];
            NSMutableDictionary *JobDic = [NSMutableDictionary dictionary];
            [JobDic setObject:dsstrs forKey:@"Job_number"];
            [self.DicArr addObject:JobDic];

            
            
            
            NSMutableDictionary *dics = [NSMutableDictionary dictionary];
            dics = [dic valueForKey:@"city_id"];
            NSString *dicStr = [dics valueForKey:@"text"];
            
            NSMutableDictionary *CompNamedic = [NSMutableDictionary dictionary];
            CompNamedic = [dic valueForKey:@"company_name"];
            NSString *CompNamedicS = [CompNamedic valueForKey:@"text"];
            NSArray *arrx = [CompNamedicS componentsSeparatedByString:@" "];
            NSString *CompNamedicStr = [arrx objectAtIndex:arrx.count-1];
            
            
            NSMutableDictionary *CompNumberDic = [NSMutableDictionary dictionary];
            CompNumberDic = [dic valueForKey:@"company_number"];
            NSString *CompNumberDicS = [CompNumberDic valueForKey:@"text"];
            NSArray *arrx1 = [CompNumberDicS componentsSeparatedByString:@" "];
            NSString *CompNumberDicStr = [arrx1 objectAtIndex:arrx1.count-1];
            
            NSMutableDictionary *job_titledic = [NSMutableDictionary dictionary];
            job_titledic = [dic valueForKey:@"job_title"];
            NSString *job_titledicS = [job_titledic valueForKey:@"text"];
            NSArray *arrx2 = [job_titledicS componentsSeparatedByString:@" "];

            NSString *job_titledicStr = [arrx2 objectAtIndex:arrx2.count-1];
            
            NSMutableDictionary *company_short_namedic = [NSMutableDictionary dictionary];
            company_short_namedic = [dic valueForKey:@"company_short_name"];
            NSString *company_short_namedicStr = [company_short_namedic valueForKey:@"text"];
            
            NSMutableArray * arr1 = [NSMutableArray arrayWithObjects:dicStr, CompNamedicStr, CompNumberDicStr, job_titledicStr , company_short_namedicStr, nil];
            [self.Allarr addObject:arr1];
//            company_short_name
        }
//        NSLog(@"%@",dics);
        
    }
    
    
    
    }
//    [dic1 isKindOfClass:[NSDictionary class]];

    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.Allarr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    favJobCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[favJobCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    

    
    cell.jobName.text = [[self.Allarr objectAtIndex:indexPath.row] objectAtIndex:3];
    cell.jobName.font = [UIFont fontWithName:@"Arial" size:14];
//    cell.companyName.font=[UIFont fontWithName:@"Arial" size:12];
    cell.companyName.text = [[self.Allarr objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.address.text = [[self.Allarr objectAtIndex:indexPath.row] objectAtIndex:0];
//    cell.address.font=[UIFont fontWithName:@"Arial" size:12];

    cell.chooseImg.tag = 3000*indexPath.row;
    
    [cell.chooseImg addTarget:self 
                       action:@selector(ChooseImgAction:)
             forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    if ([self.tagarr containsObject:indexPath])
    {
        [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:(UIControlStateNormal)];
    }
    else
    {
        [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
    
    }

    
    
    
    // Configure the cell...
    
    return cell;
}

-(void)ChooseImgAction:(UIButton *)bnt
{
    itag = bnt.tag/3000;
    if (![self.tagarr containsObject:[NSIndexPath indexPathForRow:itag inSection:0]])
    {
        [self.tagarr addObject:[NSIndexPath indexPathForRow:itag inSection:0]];

        [self.tableView reloadData];
    }
    else
    {
        [self.tagarr removeObject:[NSIndexPath indexPathForRow:itag inSection:0]];

        [self.tableView reloadData];
    }
    
    self.ChangeArr = self.tagarr;
    NSLog(@"self.ChangeArr----->%@",self.ChangeArr);

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     JobMessageViewController *detailViewController = [[JobMessageViewController alloc] init];
     // ...
     // Pass the selected object to the new view controller.
    [detailViewController.JobNumDic retain];
    detailViewController.JobNumDic = [self.DicArr objectAtIndex:indexPath.row];

     [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController.JobNumDic release];
     [detailViewController release];
     }

@end
