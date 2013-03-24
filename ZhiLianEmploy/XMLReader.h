//
//  XMLReader.h
//  lesson42documents and data
//
//  Created by Ibokan on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLReader : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError **errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
