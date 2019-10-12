//
//  SM4_Until.h
//  SM4_Mac
//
//  Created by 张冲 on 2019/8/19.
//  Copyright © 2019 张冲. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SM4_Until : NSObject
+(NSString *)sm4MacSecretKey:(NSString *)secretKey plaintext:(NSString *)plaintext  initValue:(NSString *)initValue;
@end

NS_ASSUME_NONNULL_END
