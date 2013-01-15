//
//  User.h
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mqyyUser : NSObject
@property(retain) NSString* name;

-(mqyyUser*)initWithName:(NSString*)name;

@end
