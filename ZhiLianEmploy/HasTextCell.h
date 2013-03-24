//
//  HasTextCell.h
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-24.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HasTextCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UITextField * text;
@end
