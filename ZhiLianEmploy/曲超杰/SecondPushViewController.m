//
//  SecondPushViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SecondPushViewController.h"
#import "RequestData.h"

@interface SecondPushViewController ()

@end

@implementation SecondPushViewController
- (void)dealloc
{
    [_IdPushArr release];
    [_textArr release];
    [_IDdicArr release];
    [_titleArr release];
    [_IdPushDic release];
    [_startdate release];
    [_EndtextView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.textArr = [[NSMutableArray new] autorelease];
//        [self.textArr retain];
        
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
        [leftbarItem release];
        [tapgestre release];
        
        
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



-(void)JieShouarticle
{
    NSMutableArray *arrID = [NSMutableArray array];
//    NSLog(@"%@",[self.textArr objectAtIndex:self.indexpaths.row]);
        RequestData *reqData = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/article/articledetail.service"
                                                withHttpMethod:@"POST"
                                                    withParams:[self.textArr objectAtIndex:self.indexpaths.row]];
    [reqData setResultData:^(id aid, NSError *error)
     {
//         NSLog(@"end------------->%@",aid);
              NSMutableDictionary *dic =[aid valueForKey:@"root"];
              NSMutableDictionary *articleDic = [dic valueForKey:@"article"];
//              NSLog(@"%@",articleDic);
              NSMutableDictionary *contentDic = [articleDic valueForKey:@"content"];
//              NSLog(@"%@",contentDic);
              NSString *textStr=  [contentDic valueForKey:@"text"];
//              NSLog(@"%@",textStr);
         
              NSMutableDictionary *TitleDic =[articleDic valueForKey:@"title"];
//              NSLog(@"%@",TitleDic);
         
              NSString *Title = [TitleDic valueForKey:@"text"];
//              NSLog(@"%@",Title);
         
              NSMutableDictionary *startdateDic = [articleDic valueForKey:@"startdate"];
              
              self.startdate = [startdateDic valueForKey:@"text"];
//              NSLog(@"%@",self.startdate);
         
              [self.titleArr addObject:Title];
              [arrID addObject:textStr];
//              NSLog(@"%@",self.IdPushArr);
              [self.IdPushArr addObject:textStr];
         
            
              [self viewDidLoad];  
         
         
          }];
         
         [reqData connect];
         
         
         
         
     }
     
    
     -(void)loadView
    {
        self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
        
        [self JieShouarticle];

        
    }
     
     
     - (void)viewDidLoad
    {
        [super viewDidLoad];
//        NSLog(@"%d",self.IdPushArr.count);
        
        UIView *backgrundViewPic = [[UIView alloc] initWithFrame:CGRectMake(0, 56, 320, 1)];
        backgrundViewPic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayline"]];
        [self.view addSubview: backgrundViewPic];
        [backgrundViewPic release];
        self.EndtextView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 70, 320, 300)] autorelease];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 240, 30)];
        if (self.IdPushArr.count != 0) 
        {
            self.EndtextView.text = [self.IdPushArr objectAtIndex:0];
            self.EndtextView.editable = NO;
            
            [self.view addSubview:self.EndtextView];
        }
        else{
//            NSLog(@"22222222222");
        }
        if (self.titleArr.count != 0) 
        {
            
            
            titleLabel.text = [self.titleArr objectAtIndex:0];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
            
            [self.view addSubview:titleLabel];
//            NSLog(@"%@",titleLabel.text);
            
        }
        else{
//            NSLog(@"11111111111");
        }
        
        [titleLabel release];
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
