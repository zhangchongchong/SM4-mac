//
//  AppDelegate.h
//  SM4_Mac
//
//  Created by 张冲 on 2019/8/19.
//  Copyright © 2019 张冲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

