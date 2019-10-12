//
//  NSData+NSString.m
//  TestFramework
//
//  Created by 中交金码 on 2018/2/8.
//  Copyright © 2018年 中交金码. All rights reserved.
//

#import "NSData+NSString.h"

@implementation NSData (NSString)

/**
 将数据转为16进制
 */
+ (NSData *)dataFromHexString:(NSString *)input {
    const char *chars = [input UTF8String];
    int i = 0;
    NSUInteger len = input.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}
@end
