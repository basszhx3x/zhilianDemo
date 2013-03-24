//
//  RealtimeRecommentCell.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "GetLastestJobCell.h"

@interface RealtimeRecommentCell : GetLastestJobCell
@property(nonatomic,retain)UILabel *post_ratio;
@property(nonatomic,assign)BOOL isSelectState;
@property(nonatomic,retain)NSString *company_number;
@property(nonatomic,retain)NSString *job_number;
@end
