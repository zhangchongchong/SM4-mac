//
//  ViewController.m
//  SM4_Mac
//
//  Created by 张冲 on 2019/8/19.
//  Copyright © 2019 张冲. All rights reserved.
//

#import "ViewController.h"
#import "SM4_Until.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   NSString *resultStr = [SM4_Until sm4MacSecretKey:@"0123456789ABCDEFFEDCBA9876543210" plaintext:@"123412341234123412341234123412341234123412341234123412341234" initValue:@"00000000000000000000000000000000"];
    NSLog(@"resultStr = %@",resultStr);
    // Do any additional setup after loading the view.
}


@end
