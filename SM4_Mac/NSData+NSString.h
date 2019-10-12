//
//  NSData+NSString.h
//  TestFramework
//
//  Created by 中交金码 on 2018/2/8.
//  Copyright © 2018年 中交金码. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSString)

/**
 将数据转为16进制
 */
+ (NSData *)dataFromHexString:(NSString *)input;
@end
