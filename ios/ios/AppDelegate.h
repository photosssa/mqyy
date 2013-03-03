//
//  AppDelegate.h
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mqyyClient.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) mqyyClient* client;

@end
