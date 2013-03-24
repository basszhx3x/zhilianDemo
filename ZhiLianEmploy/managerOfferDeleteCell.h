//
//  managerOfferDeleteCell.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface managerOfferDeleteCell : UITableViewCell
@property(nonatomic,retain)UIImageView * senderImg;
@property(nonatomic,retain)UILabel * offerName;
@property(nonatomic,retain)UILabel * companyName;
@property(nonatomic,retain)UILabel * date;
@property(nonatomic,retain)UILabel * address;
@property(nonatomic,retain)UIImageView * accessoryImg;
@property(nonatomic,retain)UIButton * deleteBtn;

@end
