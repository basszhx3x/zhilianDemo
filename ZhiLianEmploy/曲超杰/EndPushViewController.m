//
//  EndPushViewController.m
//  ZhiLianLQX
//
//  Created by tony J on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "EndPushViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RequestData.h"
@interface EndPushViewController ()

@end

@implementation EndPushViewController

- (void)dealloc
{
    [_startdate release];
    [_EndtextView release];
 [_IdPushArr release];
 [_IdPushDic release];
 [_titleArr release];
 [_IDdicArr release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.IdPushArr = [NSMutableArray array];
//        [self.IdPushArr retain];
        
        self.IdPushDic = [NSMutableDictionary dictionary];
//        [self.IdPushDic retain];
        
        self.titleArr= [NSMutableArray array];
//        [self.titleArr retain];

        self.IDdicArr= [NSMutableArray array];
//        [self.IDdicArr retain];
        
        self.startdate = [[NSMutableString new] autorelease];
        
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
        [imagev release];
        [tapgestre release];
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

-(void)webjieshouData
{
    NSMutableArray *arrID = [NSMutableArray array];
//    for (int i = 0; i<8; i++)
//    {
        RequestData *reqData = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/article/articledetail.service"
                                                withHttpMethod:@"GET"
                                                    withParams:[[self.IDdicArr objectAtIndex:self.EndIndexPath.section] objectAtIndex:self.EndIndexPath.row]];

//    NSLog(@"%@",[[self.IDdicArr objectAtIndex:self.EndIndexPath.section] objectAtIndex:self.EndIndexPath.row]);
//        NSLog(@"self.IDdicArr----------->%@",self.IDdicArr);
//        NSLog(@"%d",self.IDdicArr.count);
    
[reqData setResultData:^(id aid, NSError *error) 
    {
//    NSLog(@"%@",aid);
        NSMutableDictionary *dic =  [aid valueForKey:@"root"];
        NSMutableDictionary *articleDic = [dic valueForKey:@"article"];
//        NSLog(@"%@",articleDic);
        NSMutableDictionary *contentDic = [articleDic valueForKey:@"content"];
//        NSLog(@"%@",contentDic);
        NSString *textStr=  [contentDic valueForKey:@"text"];
//        NSLog(@"%@",textStr);
        
        NSMutableDictionary *TitleDic = [articleDic valueForKey:@"title"];
//         NSLog(@"%@",TitleDic);
        
        NSString *Title = [TitleDic valueForKey:@"text"];
//        NSLog(@"%@",Title);
        
        NSMutableDictionary *startdateDic =  [articleDic valueForKey:@"startdate"];
        
        self.startdate = [startdateDic valueForKey:@"text"];
//        NSLog(@"%@",self.startdate);
        
        [self.titleArr addObject:Title];
        [arrID addObject:textStr];
//        NSLog(@"%@",self.IdPushArr);
        [self.IdPushArr addObject:textStr];
   [self viewDidLoad];     
}];
    
    [reqData connect];

    
    
    
}


-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    
    [self webjieshouData];
    
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:<#(SEL)#>]
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"%d",self.IdPushArr.count);

    UIView *backgrundViewPic = [[UIView alloc] initWithFrame:CGRectMake(0, 56, 320, 1)];
    backgrundViewPic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayline"]];
    [self.view addSubview: backgrundViewPic];
    [backgrundViewPic release];
    self.EndtextView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 70, 320, 300)] autorelease];
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40, 5, 240, 30)] autorelease];
    if (self.IdPushArr.count != 0) 
    {
        self.EndtextView.text = [self.IdPushArr objectAtIndex:0];
        self.EndtextView.editable = NO;
        
    [self.view addSubview:self.EndtextView];
    }
    else{
//        NSLog(@"22222222222");
    }
    if (self.titleArr.count != 0) 
    {
        

            titleLabel.text = [self.titleArr objectAtIndex:0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        
        [self.view addSubview:titleLabel];
//        NSLog(@"%@",titleLabel.text);
        
    }
    else{
//        NSLog(@"11111111111");
    }
    
    
    UILabel *startdataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 20)];
    startdataLabel.text = self.startdate;
    startdataLabel.textColor = [UIColor colorWithRed:183/255.f green:183/255.f blue:183/255.f alpha:1];
    startdataLabel.textAlignment = NSTextAlignmentCenter;
    startdataLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [self.view addSubview:startdataLabel];
    [startdataLabel release];
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
