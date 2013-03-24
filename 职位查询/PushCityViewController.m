//
//  PushCityViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "PushCityViewController.h"
#import "XMLReader.h"

@interface PushCityViewController ()

@end
static NSDictionary *dic;

@implementation PushCityViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = @"选择地区";
        
        self.arr = [NSMutableArray array];
//        [self.arr retain];
        self.arrfirstCode = [NSMutableArray array];
//        [self.arrfirstCode retain];
        
    }
    return self;
}

-(NSMutableArray *)secondCityType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"];
    NSData *dataP = [NSData dataWithContentsOfFile:path];
    dic = [XMLReader dictionaryForXMLData:dataP error:nil];
    NSMutableDictionary *rootDic = [dic valueForKey:@"root"];
    NSMutableDictionary *basedataDic = [rootDic valueForKey:@"basedata"];
    NSMutableDictionary *cityDic = [basedataDic valueForKey:@"city"];
    NSLog(@"cityDic--------------->%@",cityDic);

    NSMutableDictionary *secondLevelDic = [cityDic valueForKey:@"secondLevel"];
    
    NSMutableArray *itemArr  = [secondLevelDic valueForKey:@"item"];
    
    NSMutableArray *cityArr = [NSMutableArray array];
    for (NSMutableDictionary *EndDic in itemArr) 
{
        NSString *textStr = [EndDic valueForKey:@"text"];
        NSString *parentStr = [EndDic valueForKey:@"parent"];
        NSString *codeStr = [EndDic valueForKey:@"code"];
    NSArray *arrs = [textStr componentsSeparatedByString:@" "];
    
    NSString *Newstr = [arrs objectAtIndex:[arrs count]-1];


    NSMutableArray *arr = [NSMutableArray arrayWithObjects:Newstr,parentStr,codeStr, nil];

        [cityArr addObject:arr];

}

    for (NSMutableArray *arrs in cityArr)
    {
        if ([[arrs objectAtIndex:1] isEqualToString:[self.arrfirstCode objectAtIndex:1]])
        {
            [self.arr addObject:[arrs objectAtIndex:0]];
        }
    }
    [self.tableView reloadData];

    return self.arr;
      
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self secondCityType];
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

//    return self.arr.count;
    
    
    
   return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
        
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
    NSNotificationCenter *Notcenter = [NSNotificationCenter defaultCenter];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObject:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forKey:@"123"];
    
    
    [Notcenter postNotificationName:@"DelegateName" object:nil userInfo:dic1];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
