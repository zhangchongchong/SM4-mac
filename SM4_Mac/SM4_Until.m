//
//  SM4_Until.m
//  SM4_Mac
//
//  Created by 张冲 on 2019/8/19.
//  Copyright © 2019 张冲. All rights reserved.
//

#import "SM4_Until.h"
#import "NSData+NSString.h"
#import "sm4/sm4.h"

@implementation SM4_Until
+(NSString *)sm4MacSecretKey:(NSString *)secretKey plaintext:(NSString *)plaintext  initValue:(NSString *)initValue{
    //16进制转byte数组
    NSData *data = [self hexToBytes:plaintext];
    NSUInteger len = [data length];
    Byte *plainByte = (Byte*)[data bytes];

    int  p = 16 - len%16;
    if (p == 16) {
        p = 0;
    }
    Byte *ret = (Byte *)malloc(len + p);
    memcpy(ret, plainByte, len);
    for (int i = 0; i < p; i ++) {
        ret[len + i] = 0x00;
    }
    unsigned long j = (len + p) / 16;
    NSData *initData = [self hexToBytes:initValue];
    NSUInteger initLen = [initData length];
    Byte *xorValue = (Byte*)malloc(initLen);
    memcpy(xorValue, [initData bytes], initLen);
    for (int i = 0; i < j ; i++) {
        Byte *temp = (Byte*)malloc(16);
        temp = [self byteSplit2byte:ret orc:temp begin:i*16 count:16];
        Byte *temp2 = [self xorByte1:temp byteLen:16 byte2:xorValue byte2Len:initLen];
        NSString *hexStr = [self hexStringFromByte:temp2];
        NSString *secretString = [self encryECBSecretKey:secretKey plainText:hexStr];
        NSData *secdata = [self hexToBytes:secretString];
        Byte *secByte = (Byte*)[secdata bytes];
        xorValue = secByte;
    }
    NSString *resultStr = [self hexStringFromByte:xorValue];
    resultStr = [resultStr uppercaseString];
    return resultStr;
}
//字符数组截取
+ (Byte *)byteSplit2byte:(Byte[])src orc:(Byte[])orc begin:(NSInteger)begin count:(NSInteger)count{
    memset(orc, 0, sizeof(char)*count);
    for (NSInteger i = begin; i < begin+count; i++){

        orc[i-begin] = src[i];
    }
    return orc;
}
//异或算法
+ (Byte *)xorByte1:(Byte*)byte1 byteLen:(NSInteger)byteLen byte2:(Byte *)byte2 byte2Len:(NSInteger)byte2Len{
    Byte *xor =  (Byte*)malloc(byteLen);
    for (int i = 0; i < byteLen && i<byte2Len; i++) {
        xor[i] = byte1[i]^byte2[i];
    }
    return xor;
}

//字节数组转换为十六进制的。
+ (NSString *)hexStringFromByte:(Byte *)bytes{

    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i< 16;i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

//16进制转byte
+(NSData *)hexToBytes:(NSString *)hexString
{
    NSMutableData *muData = [NSMutableData data];
    for (int i = 0; i + 2 <= hexString.length; i += 2)
    {
        NSRange range = NSMakeRange(i, 2);
        NSString *hexStr = [hexString substringWithRange:range];
        NSScanner *scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [muData appendBytes:&intValue length:1];
        }
    return muData;
}
//sm4加密
+(NSString *)encryECBSecretKey:(NSString *)secretKey plainText:(NSString *)plainText{
    sm4_context ctx;
    NSData *data = [self hexToBytes:secretKey];
    Byte *keyByte = (Byte*)[data bytes];
    //将key传给加密算法
    sm4_setkey_enc(&ctx,keyByte);
    NSData *plainData = [self hexToBytes:plainText];
    NSInteger plainLen = plainData.length;
    Byte *plainByte = (Byte*)[plainData bytes];
    unsigned char output[128];
    unsigned char intput[128];
    for (unsigned int i = 0;i<plainLen; i++) {
        intput[i] = plainByte[i];
    }
    //进行加密
    sm4_crypt_ecb(&ctx,SM4_ENCRYPT,32,intput,output);

    NSString *outputStr = @"";
    for(unsigned int i=0;i<32;i++){
        outputStr = [NSString stringWithFormat:@"%@%02x",outputStr,output[i]];
    }
    return outputStr;
}
//sm4解密
+(NSString *)dencryECBSecretKey:(NSString *)secretKey plainText:(NSString *)plainText{
    sm4_context ctx;
    NSData *data = [self hexToBytes:secretKey];
    Byte *keyByte = (Byte*)[data bytes];
    //将key传给加密算法
    sm4_setkey_dec(&ctx,keyByte);
    NSData *plainData = [self hexToBytes:plainText];
    NSInteger plainLen = plainData.length;
    Byte *plainByte = (Byte*)[plainData bytes];
    unsigned char output[128];
    unsigned char intput[128];
    for (unsigned int i = 0;i<plainLen; i++) {
        intput[i] = plainByte[i];
    }
    //进行加密
    sm4_crypt_ecb(&ctx,SM4_DECRYPT,32,intput,output);

    NSString *outputStr = @"";
    for(unsigned int i=0;i<32;i++){
        outputStr = [NSString stringWithFormat:@"%@%02x",outputStr,output[i]];
    }
    return outputStr;
}


@end
