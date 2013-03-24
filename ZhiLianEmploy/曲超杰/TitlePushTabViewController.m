//
//  TitlePushTabViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-23.
//  Copyright (c) 2013年 Ibokan. All rights reserved.


#import "TitlePushTabViewController.h"
#import "RequestData.h"
#import "SecondPushViewController.h"
#import "ForPageCell.h"

@interface TitlePushTabViewController ()

@end

@implementation TitlePushTabViewController

- (void)dealloc
{
    [_IDTitleArr release];
    [_IDChannelPushArr release];
    [_IDChannelPushTitleArr release];
    [_countArr release];
    [_IDTextArr release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.IDTitleArr = [NSMutableArray array];
//        [self.IDTitleArr retain];
        self.IDChannelPushArr = [NSMutableArray array];
//        [self.IDChannelPushArr retain];
        self.IDChannelPushTitleArr =[NSMutableArray array];
//        [self.IDChannelPushTitleArr retain];
       self.countArr =[NSMutableArray array];
//        [self.countArr retain];
        self.IDTextArr = [NSMutableArray array];
//        [self.IDTextArr retain];
        
        UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting-form-back-button"]];
        UILabel *labels = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 40, 30)];
        labels.backgroundColor = [UIColor clearColor];
        labels.text = @"返回";
        labels.textColor = [UIColor whiteColor];
        [imagev addSubview:labels];
        [labels release];
        
        UIBarButtonItem *leftbarItem = [[UIBarButtonItem  alloc] initWithCustomView :imagev];        
        self.navigationItem.leftBarButtonItem = leftbarItem;
        UITapGestureRecognizer *tapgestre = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                    action:@selector(actions)];
        
        [imagev addGestureRecognizer:tapgestre];
        [tapgestre release];
        [imagev release];
        [leftbarItem release];
        
        
    }
    return self;
}

-(void)actions
{
    UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting-form-back-button-click"]];
    self.navigationItem.leftBarButtonItem.customView = imagev;
    UILabel *labels = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 40, 30)];
    labels.backgroundColor = [UIColor clearColor];
    labels.text = @"返回";
    labels.textColor = [UIColor whiteColor];
    [imagev addSubview:labels];
    [labels release];
    [imagev release];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)loadView
{
    [super loadView];
//    NSLog(@"%@",self.NameText);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self JieShouData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)JieShouData
{
//    NSLog(@"%@",[self.IDChannelPushArr objectAtIndex:self.section.section]); 
    int i = (NSInteger)self.pushTag/1000-1;
    RequestData *ReqData = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/article/articlelist.service"
                                            withHttpMethod:@"GET"
                                                withParams: [self.IDChannelPushArr objectAtIndex:i]] ;
     
    [ReqData setResultData:^(id aid, NSError *error)
     {
      //   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       //  NSMutableArray *arr = [NSMutableArray array];
         
//         NSLog(@"22========0%@",aid);
         NSMutableDictionary *dic = [aid valueForKey:@"root"];
//         NSLog(@"11111%@",dic);
             NSMutableDictionary *Channeldic = [dic valueForKey:@"channel"];
//             NSLog(@"3333 %@",Channeldic);
         NSMutableDictionary *articlesdic = [Channeldic valueForKey:@"articles"];
//         NSLog(@"44444------> %@",articlesdic);
         
         NSMutableDictionary * NameDic =  [Channeldic valueForKey:@"name"];
//         NSLog(@"%@",NameDic);
         self.NameText = [NameDic valueForKey:@"text"];
//         NSLog(@"%@",self.NameText);
         
        NSMutableArray *arr = [articlesdic valueForKey:@"article"];
//         NSLog(@"5555--->  %d",arr.count);
         self.countArr = arr;
         for (NSMutableDictionary *dic in arr)
         {
             NSString *str = nil;
             str = [[dic valueForKey:@"title"] valueForKey:@"text"];
//             NSLog(@"str == %@",str);
             
             NSString *IDstr = nil;
             IDstr = [[dic valueForKey:@"id"] valueForKey:@"text"];
             NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
             [dic1 setObject:IDstr forKey:@"id"];
             
             [self.IDTextArr addObject: dic1];
//             NSLog(@"%@",self.IDTextArr);
             [self.IDChannelPushTitleArr addObject:str];
         }
         

         [self.tableView reloadData];
         
     }];
    [ReqData connect];
    
    
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
//    return self.countArr.count;
////    return self.IDChannelPushTitleArr.count;
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return self.IDChannelPushTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ForPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell == nil)
    {
        cell = [[[ForPageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
    }
//    NSLog(@"%@",[self.IDChannelPushTitleArr objectAtIndex:indexPath.row]);
    cell.textLabel.text = [self.IDChannelPushTitleArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
    self.title = self.NameText;
    
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
    
     SecondPushViewController *detailViewController = [[SecondPushViewController alloc] init];
     // ...
     // Pass the selected object to the new view controller.
    detailViewController.textArr = self.IDTextArr;
//    NSLog(@"%d",detailViewController.textArr.count);
    detailViewController.indexpaths = indexPath;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

@end
