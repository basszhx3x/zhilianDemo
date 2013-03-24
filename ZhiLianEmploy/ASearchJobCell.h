//
//  ASearchJobCell.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASearchJobCell : UITableViewCell
{
    BOOL change;

}
@property(nonatomic,retain)UIButton * headImg;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UIImageView * accessoryImg;
@property(nonatomic,retain)UIView * identifier;

@end
