//
//  RegisterViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "RegisterViewController.h"
#import "RequestData.h"
#import "NSString+removeSaceAndEnter.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        postArr=[[NSMutableArray alloc] initWithObjects:@"qq.com",@"sina.com",@"163.com",@"yahooo.com",@"gmail.com",@"126.com",@"Foxmail.com", nil];
    }
    return self;
}

-(void)dealloc
{
    [_MyImageView release];
    [postArr release];
    [super dealloc];

}

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)]autorelease];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    
    self.title = @"用户注册";
    self.MyImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registerBg"]] autorelease];
    self.MyImageView.frame = CGRectMake(5, 5, 308, 210);
    self.MyImageView.userInteractionEnabled = YES;
    
    phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(85, 6, 210, 40)];
    phoneNum.delegate=self;
    phoneNum.borderStyle = UITextBorderStyleRoundedRect;
    phoneNum.placeholder=@"请输入手机号码";
    phoneNum.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.MyImageView addSubview:phoneNum];
    [phoneNum release];
    
    post = [[UITextField alloc] initWithFrame:CGRectMake(85, 58, 210, 40)];
    post.delegate=self;
    post.borderStyle = UITextBorderStyleRoundedRect;
    post.placeholder=@"请输入邮箱地址";
    post.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.MyImageView addSubview:post];
    [self.view addSubview:self.MyImageView];
    [post release];
    
    secret = [[UITextField alloc] initWithFrame:CGRectMake(85, 110, 210, 40)];
    secret.delegate=self;
    secret.borderStyle = UITextBorderStyleRoundedRect;
    secret.placeholder=@"请输入密码";
    secret.secureTextEntry=YES;
    secret.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.MyImageView addSubview:secret];
    [self.view addSubview:self.MyImageView];
    [secret release];
    
    
    reSecret= [[UITextField alloc] initWithFrame:CGRectMake(85, 162, 210, 40)];
    reSecret.delegate=self;
    reSecret.borderStyle = UITextBorderStyleRoundedRect;
    reSecret.placeholder=@"请输入密码";
    reSecret.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    reSecret.secureTextEntry=YES;
    [self.MyImageView addSubview:reSecret];
    [self.view addSubview:self.MyImageView];
    [reSecret release];
    
    
    UIButton *LogInBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [LogInBtn setBackgroundImage:[UIImage imageNamed:@"loginPress"] forState:(UIControlStateNormal)];
    [LogInBtn setBackgroundImage:[UIImage imageNamed:@"loginNormal"] forState:(UIControlStateSelected)];
    LogInBtn.frame = CGRectMake(5, 220, 142, 44);
    [LogInBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [LogInBtn addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LogInBtn];
    
    UIButton *Signin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [Signin setBackgroundImage:[UIImage imageNamed:@"registerPress"] forState:(UIControlStateNormal)];
    [Signin setBackgroundImage:[UIImage imageNamed:@"registerNormal"] forState:(UIControlStateSelected)];
    Signin.frame = CGRectMake(170, 220, 142, 44);
    
    [Signin setTitle:@"已有账户" forState:(UIControlStateNormal)];
    
    [Signin addTarget:self
               action:@selector(pop:)
     forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:Signin];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -selffuc-
-(void)Register:(UIButton *)sender
{
//信息校验
//    NSLog(@"post.text= %@",post.text);
//    if (post.text==nil) {
//        UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [noPost show];
//        [noPost release];
//        return;
//    }
//    
//    if(post.text!=nil)
//    {
//        NSArray * arr=[post.text componentsSeparatedByString:@"@"];
//        
//        
//       if ([arr count]==2)
//       {
//           if ([postArr containsObject:[arr objectAtIndex:1]])
//           {
//               return;
//               
//           }
//           
//           else
//           {
//               UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入的邮箱地址不合法，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//               [noPost show];
//               [noPost release];
////               return;
//           }
//        }
//        else
//        {
//            UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入的邮箱地址不合法，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [noPost show];
//            [noPost release];
////            return;
//        
//        }
//    
//    }
// 
////    
//    if (secret.text==nil&&post.text!=nil)
//    {
//        UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [noPost show];
//        [noPost release];
//        return;
//    }
//    
//    if (reSecret.text==nil&&secret.text!=nil&&post.text!=nil)
//    {
//        UIAlertView * noPost=[[UIAlertView alloc] initWithTitle:nil message:@"请确输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [noPost show];
//        [noPost release];
//        return;
//    }
//    
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    [dic setObject:post.text forKey:@"email"];
    [dic setObject:secret.text forKey:@"password"];
    [dic setObject:phoneNum.text forKey:@"Mobile"];
    
    RequestData * data=[RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/register.aspx" withHttpMethod:@"GET" withParams:dic];
    [data setResultData:^(id aid, NSError *error) {
        if ([[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"] removeSpaceAndEnter:[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]] integerValue]==1) {
            UIAlertView * alarm=[[UIAlertView alloc] initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alarm show];
            [alarm release];
        }
        else
        {
            UIAlertView * alarm=[[UIAlertView alloc] initWithTitle:@"注册失败，失败原因" message:@"服务器异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alarm show];
            [alarm release];
        
        }
    }];
    
    [data connect];
    
    

}


-(void)pop:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end
