//
//  ZhiLianManager.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ZhiLianBlock)(id result,id result1,id result2);
@interface ZhiLianManager : NSObject
{
    ZhiLianBlock finishBlock;

}
-(void)setfinishBlock:(ZhiLianBlock)aBlock;
-(void)loginReturnInforequestDataWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//登陆返回数据
-(void)jobSearchWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//职位搜索器查询
-(void)getLastestJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//获取今日最新职位表
-(void)JobApplyRecordJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//职位申请记录

-(void)FavorJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//职位收藏记录
-(void)managerOfferWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//查看人事经理来信

-(void)getMailContentWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//获取邮件内容

-(void)getScanResumeCompanyListWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//获取浏览简历的公司列表
-(void)getScanResumeCompanyInfoWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//获取浏览简历的公司详情

-(void)getJobApplyDetailInfoWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams;//查看职位申请记录详情



@end
