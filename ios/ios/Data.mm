//
//  Controls.m
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import "Data.h"


@implementation mqyyData
{
    @private
    NSMutableArray* _categories;
}
@synthesize categories = _categories;
-(mqyyData*)initWithCategories:(NSArray*)categories
{
    _categories = [[NSMutableArray alloc]initWithArray:categories];
    return self;
}

-(mqyyData*)init
{
    _categories = [[NSMutableArray alloc]init];
    return self;
}

-(void)addCategory:(mqyyCategory*)category
{
    [_categories addObject:category];
}

@end



@interface mqyyCategory ()
{
@private
    NSString* _name;
    int _popular;
    NSMutableArray* _programs;
    NSString* _id;
}

@end

@implementation mqyyCategory

@synthesize name=_name, popular=_popular, programs=_programs, cid=_id;

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular programs:(NSArray*)programs
{
    self = [self initWithName:name popular:popular id:_id];
    _programs = [[NSMutableArray alloc] initWithArray:programs];
    return self;
}

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular id:(NSString*)cid
{
    _programs = [[NSMutableArray alloc]init];
    _name = name;
    _popular = popular;
    _id = cid;
    return self;
}

-(void)addProgram:(mqyyProgram*)program
{
    [_programs addObject:program];
}

-(void)clearProgram
{
    [_programs removeAllObjects];
}

@end

@interface mqyyProgram()
{
@private
    NSString* _name;
    int _popular;
    mqyyUser* _reader;
    NSMutableArray* _sections;
    mqyyUserConforms* _conforms;
    enum mqyyProgramState _state;
    NSString* _id;
    NSString* _brief;
}
@end

@implementation mqyyProgram
@synthesize name=_name,popular=_popular,reader=_reader, sections=_sections, conforms=_conforms, state=_state, pid=_id
    , brief = _brief;
-(mqyyProgram*)init
{
    return self;
}

-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular reader:(mqyyUser*)reader sections:(NSArray *)sections conforms:(mqyyUserConforms*)conforms state:(enum mqyyProgramState)state brief:(NSString*)brief
{
    self = [self initWithName:name popular:popular id:_id brief:brief reader:reader state:state conforms:conforms];
    _sections = [[NSMutableArray alloc]initWithArray:sections];
    for (int ix=0; ix < [sections count]; ++ ix) {
        ((mqyySection*)[sections objectAtIndex:ix]).program = self;
    }
    return self;
}
-(mqyySection*)sectionAtIndex:(NSInteger)index
{
    if (index < 0) {
        return nil;
    }
    if (index >= [[self sections] count]){
        return nil;
    }
    return [[self sections]objectAtIndex:index];
}

-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular id:(NSString *)pid brief:(NSString*)brief reader:(mqyyUser*)reader state:(enum mqyyProgramState)state conforms:(mqyyUserConforms*)conforms
{
    _id = pid;
    _name = name;
    _popular = popular;
    _sections = [[NSMutableArray alloc]init];
    _conforms = conforms;
    _state = state;
    _reader = reader;
    return self;
}

-(void)addSection:(mqyySection*)section
{
    section.program = self;
    [_sections addObject:section];
}
-(void)clearSection
{
    [_sections removeAllObjects];
}

@end


@interface mqyySection()
{

@private
    NSString* _name;
    NSString* _url;
    NSInteger _index;
}
@end


@implementation mqyySection
{
    @private
    NSString* _id;
}
@synthesize name=_name, url=_url, program, cached,index=_Index, sid=_id;
-(mqyySection*) initWithId:(NSString*)sid  index:(NSInteger)index
{
    _id = sid;
    _index = index;
    return self;
}
-(mqyySection*) initWithName:(NSString*)name url:(NSString*)url index:(NSInteger)index;
{
    _name = name;
    _url = url;
    cached = NO;
    _index = index;
    return self;
}
-(mqyySection*) preSection
{
    return [[self program]sectionAtIndex:[self index] - 1];
}
-(mqyySection*) nextSection
{
    return [[self program]sectionAtIndex:[self index] + 1];
}

@end

@implementation mqyyUserConform
{
    @private
    mqyyUser* _user;
}
@synthesize rate, comment, user=_user;
-(mqyyUserConform*) initWithUser:(mqyyUser*)user rate:(NSInteger)rate_ comment:(NSString*)comment_
{
    _user = user;
    rate = rate_;
    comment = comment_;
    return self;
}

@end

@implementation mqyyUserConforms
{
    @private
    float _rate;
    NSString* _id;
    NSMutableArray* _conforms;
}

@synthesize conforms=_conforms, rate=_rate, cid=_id;

-(mqyyUserConforms*) initWithId:(NSString*)cid rate:(float)rate
{
    _id = cid;
    _rate = rate;
    _conforms = [[NSMutableArray alloc]init];
    return self;
}

-(void)addConform:(mqyyUserConform*)conform
{
    [_conforms addObject:conform];
}

-(mqyyUserConforms*) initWithConforms:(NSArray*)conforms_
{
    self = [self initWithId:_id rate:0];
    float rate = 0;
    if([conforms_ count] != 0){
        for(NSInteger ix = 0; ix < [conforms_ count];++ix)
        {
            rate += [(mqyyUserConform*)[conforms_ objectAtIndex:ix] rate];
        }
        _rate = rate / [conforms_ count];
    }
    _conforms = [[NSMutableArray alloc]initWithArray:conforms_];
    return self;
}

@end
