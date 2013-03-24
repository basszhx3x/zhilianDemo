//
//  RequestDataforRealtime.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "RequestDataforRealtime.h"
#import "URLEncode.h"
#import "XMLReader.h"
@implementation RequestDataforRealtime
-(void)dealloc
{   
    [super dealloc];
}
+(RequestDataforRealtime *)requestDataWithURL:(NSString *)aurl withHttpMethod:(NSString *)ahttpMethod withParams:(NSMutableDictionary *)aDicwithParams
{
    RequestDataforRealtime *request = [[[RequestDataforRealtime alloc]init]autorelease];
    
    request.url = aurl;
    request.httpMethod = ahttpMethod;
    request.params = aDicwithParams;
    
    return request;
}
-(void)connect
{
    NSURL *url1 = nil;
    

    url1 = [NSURL URLWithString:[self targetStringforURL:self.url]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(NSString *)targetStringforURL:(NSString *)aUrlStr
{
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString setString:aUrlStr];
    NSArray *keyArray = [[self.params keyEnumerator] allObjects];
    for (int i = 0;i<keyArray.count ; i++) {
        if (i==0) {
            [mutableString appendFormat:@"?%@=",[keyArray objectAtIndex:0]];
        }
        else
            [mutableString appendFormat:@"&%@=",[keyArray objectAtIndex:i]];

    }
    [mutableString appendFormat:@"&%@=%@",[URLEncode encodeUrlStr:@"f"],[URLEncode encodeUrlStr:@"p"]];
    NSString *url2 = [NSString stringWithString:mutableString];
    NSString * md5 = [self getMD5String:url2];
    url2 = [url2 stringByAppendingFormat:@"%@",md5];
    
    [mutableString setString:url2];
     //NSLog(@"%@",mutableString);
    for (int i =0 ; i< keyArray.count; i++) {
        
        NSMutableString *str = [NSMutableString stringWithString:[self.params objectForKey:[keyArray objectAtIndex:i]]];
        [str setString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        // NSLog(@"uticket = %@",str);
        NSRange rang = [mutableString rangeOfString:[NSString stringWithFormat:@"%@=",[keyArray objectAtIndex:i]]];
       // NSLog(@"%@",str);
       // NSLog(@"%d",rang.location);
        [mutableString insertString:str atIndex:rang.location+rang.length];
    }
   
    //TODO:
   
    
   
     //[mutableString setString:[mutableString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSLog(@"%@",mutableString);
    
    
    return mutableString;
}

- (NSString *) getMD5String:(NSString *)url {
	
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];
	//NSString *desp = [date description];
	
	NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];
	NSString *md5Result = [self md5:md5src];
	NSLog(@"md5:%@", md5Result);
	
	NSString *result = nil;
	if (NSNotFound == [url rangeOfString:@"?"].location)
    {
		result = [NSString stringWithFormat:@"?t=%@&e=%@", paramT, md5Result];
	}
    else
    {
		result = [NSString stringWithFormat:@"&t=%@&e=%@", paramT, md5Result];
	}
	
	return result;
	
}

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    resultdata = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [resultdata appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError * error = [[NSError new]autorelease];
    NSDictionary * dic=[XMLReader dictionaryForXMLData:resultdata error:&error];
    
    if (dic==nil)
    {
        NSLog(@"error=%@",[error localizedDescription]);
        if (resultDataBlock) {
            resultDataBlock(nil,error);
        }
        [connection cancel];
       
    }
    else
    {
        if (resultDataBlock) {
            resultDataBlock(dic,nil);
        }
        [connection cancel];
        
    }
    
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    if (resultDataBlock) {
        resultDataBlock(nil,error);
    }
}

@end
