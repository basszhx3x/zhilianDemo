//
//  PublishTimeViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "PublishTimeViewController.h"
#import "XMLReader.h"
@interface PublishTimeViewController ()

@end
static NSDictionary *dic;
@implementation PublishTimeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = @"选择发布时间";
        self.timearr = [NSMutableArray array];
        
    }
    return self;
}

-(void)setStrBlock:(PublishTimeViewControllerBlock)block
{
    if (strBlock != block)
    {
        [strBlock release];
        strBlock = [block copy];
    }
}

-(void)PublishTime
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    dic = [XMLReader dictionaryForXMLData:data error:nil];
    NSLog(@"dic---------->%@",dic);
    NSMutableDictionary *rootDic = [NSMutableDictionary dictionary];
    rootDic = [dic valueForKey:@"root"];
    NSMutableDictionary *basedataDic = [NSMutableDictionary dictionary];
    basedataDic = [rootDic valueForKey:@"basedata"];
    NSLog(@"basedataDic----------->%@",basedataDic);
    NSMutableDictionary *publishDateDic = [NSMutableDictionary dictionary];
    publishDateDic = [basedataDic valueForKey:@"publishDate"];
    NSLog(@"publishDateDic----------->%@",publishDateDic);
    NSMutableArray *arrItem = [NSMutableArray array];
    arrItem = [publishDateDic valueForKey:@"item"];
//    NSMutableArray *arr1 = [NSMutableArray array];
    for (NSMutableDictionary *Itemdic in arrItem)
    {

        NSString *codeStr = [Itemdic valueForKey:@"code"];
        NSString *textStr = [Itemdic valueForKey:@"text"];
        NSArray *arrs = [NSArray array];
        arrs = [textStr componentsSeparatedByString:@" "];
        
        NSString *Newstr = [arrs objectAtIndex:[arrs count]-1];

        NSLog(@"codeStr---%@,textStr----%@",codeStr,textStr);
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:codeStr,Newstr, nil];
        [self.timearr addObject:arr];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self PublishTime];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSLog(@"%d",self.timearr.count);
    return self.timearr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.timearr objectAtIndex:indexPath.row] objectAtIndex:1];
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
    
    if (strBlock)
    {
        strBlock([tableView cellForRowAtIndexPath:indexPath].textLabel.text,[[self.timearr objectAtIndex:indexPath.row] objectAtIndex:0]);
    }
    
     [self.navigationController popViewControllerAnimated:YES];
    
     
}

@end
