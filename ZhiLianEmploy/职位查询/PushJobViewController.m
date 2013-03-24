//
//  PushJobViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "PushJobViewController.h"
#import "XMLReader.h"
@interface PushJobViewController ()

@end
static NSDictionary *dic;
@implementation PushJobViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
         self.title = @"选择职位";
        
        self.arr = [NSMutableArray array];
        self.PushArr = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self JobType];
    
    NSLog(@"%@",[self.arr objectAtIndex:0]);
    
    
}
-(NSMutableArray *)JobType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"];
    NSData *dataP = [NSData dataWithContentsOfFile:path];
    dic = [XMLReader dictionaryForXMLData:dataP error:nil];
    NSMutableDictionary *rootDic = [dic valueForKey:@"root"];

    NSMutableDictionary *basedataDic = [rootDic valueForKey:@"basedata"];

    NSMutableDictionary *small_Job_typeDic = [basedataDic valueForKey:@"small_Job_type"];
    NSLog(@"small_Job_typeDic--------------->%@",small_Job_typeDic);    
    NSMutableArray *itemArr = [NSMutableArray array];
    itemArr = [small_Job_typeDic valueForKey:@"item"];
    NSMutableArray *Endarr = [NSMutableArray array];
    for (NSMutableDictionary *EndDic in itemArr) 
    {
        NSString *textStr = [EndDic valueForKey:@"text"];

        NSString *categoryidStr = [EndDic valueForKey:@"categoryid"];
        NSString *codeStr = [EndDic valueForKey:@"code"];
        NSArray *arrs = [NSArray array];
        arrs = [textStr componentsSeparatedByString:@" "];
        
        NSString *Newstr = [arrs objectAtIndex:[arrs count]-1];

        
        NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:Newstr,categoryidStr,codeStr, nil];
        
        [Endarr addObject:arr1];
    }

    for (NSMutableArray *arrs in Endarr)
    {
        if ([[self.PushArr objectAtIndex:1] isEqualToString:[arrs objectAtIndex:1]]) 
        {
            [self.arr addObject:[arrs objectAtIndex:0]];
        }
        
    }
//        [self.arr removeObjectAtIndex:0];
    return self.arr;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.*/
    [self.delegate pushJobViewController:self PushJobViewStr:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    
     [self.navigationController popToRootViewControllerAnimated:YES];
     
}

@end
