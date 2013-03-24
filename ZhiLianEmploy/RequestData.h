//
//  RequestData.h
//  ZhiLianLQX
//
//  Created by Ibokan on 13-2-20.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void(^ resultObject) (id aid,NSError *error);


@interface RequestData : NSObject<NSURLConnectionDataDelegate>
{
    NSString *_url;
    NSString *_httpMethod;
    NSMutableDictionary *_params;
    NSMutableData *resultdata;
    
    
    resultObject resultDataBlock;
    
}
@property(nonatomic,retain)NSString *url;
@property(nonatomic,retain)NSString *httpMethod;
@property(nonatomic,retain)NSMutableDictionary *params;

+(RequestData *)requestDataWithURL:(NSString *)aurl
                    withHttpMethod:(NSString *)ahttpMethod
                        withParams:(NSMutableDictionary *)aDicwithParams;

-(void)connect;
-(void)setResultData:(resultObject)block;
@end
