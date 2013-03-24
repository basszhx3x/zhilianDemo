//
//  DawnCusTabBarViewController.m
//  selfCustom
//
//  Created by Ibokan on 12-12-25.
//  Copyright (c) 2012年 Ibokan. All rights reserved.
//

#import "CusTabBarViewController.h"

@interface CusTabBarViewController ()

@end

@implementation CusTabBarViewController
@synthesize shareButton = _shareButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Sharebtn:) name:@"btn" object:nil];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_barBView release];_barBView = nil;
    [_shareButton release],_shareButton = nil;
    
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    
    //self.view.backgroundColor = [UIColor clearColor];
    
    self.tabBar.hidden =YES;
    
    
    [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320, 480)];
    
    
    [self.tabBar removeFromSuperview];
    self.barBView = [[[UIView alloc]initWithFrame:CGRectMake(0, 480-49, 320, 49)]autorelease];
    self.barBView.tag = 3000;
    self.barBView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bigdownPic.png"]];
    [self.view addSubview:self.barBView];
    
    
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    oneBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"duan"]];
    [oneBtn setImage:[UIImage imageNamed:@"s2"] forState:0];
    [oneBtn setImage:[UIImage imageNamed:@"s1"] forState:UIControlStateSelected];
    oneBtn.tag = 1000;
    oneBtn.frame = CGRectMake(0, 0, 64, 49);
    [oneBtn addTarget:self action:@selector(oneChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.barBView addSubview:oneBtn];
    

    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.backgroundColor = [UIColor clearColor];
    [twoBtn setImage:[UIImage imageNamed:@"i2.png"] forState:0];
    [twoBtn setImage:[UIImage imageNamed:@"i1.png"] forState:UIControlStateSelected];
    twoBtn.tag = 1001;
    twoBtn.frame = CGRectMake(64, 0, 64, 49);
    [twoBtn addTarget:self action:@selector(oneChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.barBView addSubview:twoBtn];
    
    

    UIButton *threeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    threeBtn.backgroundColor = [UIColor clearColor];
   [threeBtn setImage:[UIImage imageNamed:@"f2.png"] forState:0];
   [threeBtn setImage:[UIImage imageNamed:@"f1.png"] forState:UIControlStateSelected];
        threeBtn.tag = 1002;

    threeBtn.frame = CGRectMake(64*2, 0, 64, 49);
    [threeBtn addTarget:self action:@selector(oneChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.barBView addSubview:threeBtn];
    
    

    UIButton *fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fourBtn setBackgroundColor:[UIColor clearColor]];
   [fourBtn setImage:[UIImage imageNamed:@"q2.png"] forState:0];
    [fourBtn setImage:[UIImage imageNamed:@"q1.png"] forState:UIControlStateSelected];
        fourBtn.tag = 1003;
    fourBtn.frame = CGRectMake(64*3, 0, 64, 49);
    [fourBtn addTarget:self action:@selector(oneChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.barBView addSubview:fourBtn];
    
    
    UIButton *FiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [FiveBtn setBackgroundColor:[UIColor clearColor]];
     [FiveBtn setImage:[UIImage imageNamed:@"m2.png"] forState:0];
    [FiveBtn setImage:[UIImage imageNamed:@"m1.png"] forState:UIControlStateSelected];
    FiveBtn.tag = 1004;
    FiveBtn.frame = CGRectMake(64*4, 0, 64, 49);
    [FiveBtn addTarget:self action:@selector(oneChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.barBView addSubview:FiveBtn];
    
    
    
    self.shareButton = oneBtn;
    self.shareButton.selected = YES;
    
    self.selectedIndex = 0;
    
}

-(void)Sharebtn:(NSNotification *)center
{
    UIButton *btn = [center.userInfo objectForKey:@"btn1"];
    [self oneChange:btn];
    
}
-(void)oneChange:(UIButton *)sender
{
    
    if ([self.shareButton isEqual: sender]) {
        return;
    }
    
    self.selectedIndex = sender.tag % 1000;
    self.shareButton.selected = NO;
    self.shareButton = sender;
    self.shareButton.selected =YES;
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
