//
//  RegisterViewController.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *phoneNum;
    UITextField * post;
    UITextField * secret;
    UITextField * reSecret;
    
    NSMutableArray * postArr;

}
@property(nonatomic,retain)UIImageView * MyImageView;

@end
