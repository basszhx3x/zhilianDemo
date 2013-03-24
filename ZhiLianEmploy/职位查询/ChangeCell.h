//
//  ChangeCell.h
//  ZhiLianLQX
//
//  Created by tony J on 13-2-20.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCell : UITableViewCell
@property(nonatomic,retain)UILabel *CellLabel;
@property(nonatomic,retain)UILabel *PicLabel;
@property(nonatomic,retain)UILabel *subLabel;

-(void)addcell;

@end