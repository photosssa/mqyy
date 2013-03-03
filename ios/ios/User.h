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
@property(readonly) NSString* uid;

-(mqyyUser*)initWithName:(NSString*)name;
-(mqyyUser*)initWithId:(NSString*)uid;

@end
