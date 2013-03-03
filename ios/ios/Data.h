//
//  Controls.h
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class mqyyCategory;
@class mqyyProgram;

@interface mqyyData : NSObject
@property(retain,readonly) NSArray* categories;
-(mqyyData*)initWithCategories:(NSArray*)categories;
-(mqyyData*)init;
-(void)addCategory:(mqyyCategory*)category;
@end

@interface mqyyCategory : NSObject
@property(retain, readonly) NSString* name;
@property(readonly)int popular;
@property(retain, readonly) NSArray* programs;
@property(retain, readonly) NSString* cid;

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular programs:(NSArray*)programs;
-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular id:(NSString*)cid;
-(void)addProgram:(mqyyProgram*)program;
-(void)clearProgram;
@end


@class mqyySection;

@interface mqyyUserConform : NSObject
@property(retain, readonly) mqyyUser* user;
@property NSInteger rate;
@property(strong) NSString* comment;
-(mqyyUserConform*) initWithUser:(mqyyUser*)user rate:(NSInteger)rate comment:(NSString*)comment;
@end

@interface mqyyUserConforms : NSObject
@property(readonly) float rate;
@property(strong) NSArray* conforms;
@property(readonly) NSString* cid;
-(mqyyUserConforms*) initWithConforms:(NSArray*)conforms;
-(mqyyUserConforms*) initWithId:(NSString*)cid rate:(float)rate;
-(void)addConform:(mqyyUserConform*)conform;
@end



enum mqyyProgramState {
    mqyyProgramStateOver
    };
@interface mqyyProgram : NSObject
@property(strong, readonly) NSString* name;
@property(readonly)int popular;
@property(retain, readonly) mqyyUser* reader;
@property(retain, readonly) NSArray* sections;
@property(strong, readonly) mqyyUserConforms* conforms;
@property(readonly) enum mqyyProgramState state;
@property(readonly) NSString* pid;
@property(readonly) NSString* brief;

-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular reader:(mqyyUser*)reader sections:(NSArray*)sections conforms:(mqyyUserConforms*)conforms state:(enum mqyyProgramState)state brief:(NSString*)brief;
-(mqyyProgram*)init;
-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular id:(NSString *)pid brief:(NSString*)brief reader:(mqyyUser*)reader state:(enum mqyyProgramState)state conforms:(mqyyUserConforms*)conforms;
-(void)addSection:(mqyySection*)section;
-(void)clearSection;
-(mqyySection*)sectionAtIndex:(NSInteger)index;
@end


@interface mqyySection : NSObject
@property(readonly) NSString* name;
@property(readonly) NSString* url;
@property BOOL cached;
@property(weak) mqyyProgram* program;
@property(readonly) NSInteger index;
@property(readonly) NSString* sid;

-(mqyySection*) preSection;
-(mqyySection*) nextSection;
-(mqyySection*) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index;
-(mqyySection*) initWithId:(NSString*)sid index:(NSInteger)index;
@end


