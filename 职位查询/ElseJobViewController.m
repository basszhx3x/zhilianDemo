//
//  ElseJobViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ElseJobViewController.h"
#import "ReportDataManage.h"
#import "ElseJobMessageViewController.h"
@interface ElseJobViewController ()

@end

@implementation ElseJobViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.ElseJobNumDic = [NSMutableDictionary dictionary];
        self.EndArr = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];

    
    
    [self.ElseJobNumDic setObject:@"1" forKey:@"Page"];
    [self.ElseJobNumDic setObject:@"10" forKey:@"Pagesize"];
    NSLog(@"%@",self.ElseJobNumDic);
    ReportDataManage *repdManage = [[ReportDataManage alloc] init];
    [repdManage readDataWithURL:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx" withHttpMethod:@"GET" Params:self.ElseJobNumDic];

    [repdManage setfinishBlock:^(id result, id result1) {
        self.EndArr = result;
        NSLog(@"arr %@",self.EndArr);
        [self.tableView reloadData];

    }];

    [repdManage release];
    UIBarButtonItem *barbut = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = barbut;
    [barbut release];
    
    
    
}

-(void)leftBarButtonAction:(UIBarButtonItem *)bnt
{
    [self.tabBarController.view viewWithTag:3000].hidden= YES;

    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSLog(@"self.endarr %@",self.EndArr);
    return self.EndArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
        
    }
    cell.textLabel.text = [[self.EndArr objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    
    // Configure the cell...
    
    return cell;
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
    
     ElseJobMessageViewController *detailViewController = [[ElseJobMessageViewController alloc] init];
     // ...
     // Pass the selected object to the new view controller.[[self.EndArr objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *str = [[self.EndArr objectAtIndex:indexPath.row] objectAtIndex:1];
    NSLog(@"%@",str);
    NSArray *arr1 = [str componentsSeparatedByString:@" "];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *str1 = [arr1 objectAtIndex:arr1.count-1];
    [dic setObject:str1 forKey:@"Job_number"];
    detailViewController.JobNumDic = dic;
    
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

@end
