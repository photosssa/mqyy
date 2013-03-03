//
//  mqyyServerStub.m
//  ios
//
//  Created by Tsukasa on 13-2-4.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "mqyyServerStub.h"

@implementation mqyyServerStub
{
@private
    NSString* _apiUrlFormat;
}
-(mqyyServerStub*)init
{
    self = [super init];
    _apiUrlFormat = @"http://42.96.138.169/api/%@";
    return self;
}

-(id)syncGet:(NSString*)api
{
    NSString* strurl = [NSString stringWithFormat:_apiUrlFormat,api];
    NSURL* url = [NSURL URLWithString:strurl];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLResponse* response;
    [request setHTTPMethod:@"Get"];
    NSError* error;
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString* strRet = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSURLConnection* connection = [NSURLConnection alloc];
    NSLog(@"%@",strRet);
    return [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
}

-(id)syncPost:(NSString*)api header:(NSDictionary*)header body:(NSData*)body
{
    NSString* strurl = [NSString stringWithFormat:_apiUrlFormat,api];
    NSURL* url = [NSURL URLWithString:strurl];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    NSEnumerator* headerEnum = [header keyEnumerator];
    id headerKey;
    while(headerKey = [headerEnum nextObject]){
        [request addValue:header[headerKey] forHTTPHeaderField:headerKey];
    }
    [request setHTTPBody:body];
    NSURLResponse* response;
    [request setHTTPMethod:@"Post"];
    NSError* error;
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString* strRet = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSURLConnection* connection = [NSURLConnection alloc];
    NSLog(@"%@",strRet);
    return [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
}

-(mqyyData*)syncGetData;
{
    mqyyData* data = [[mqyyData alloc]init];
    NSArray* jdata = [self syncGet:@"Category"];
    ///这里用framework的json解析， 要求ios5.0
    NSInteger count = [jdata count];
    for (NSInteger ix = 0; ix < count; ++ix) {
        [data addCategory:[self getCategory:[jdata objectAtIndex:ix]]];
    }
    return data;
}

-(mqyyCategory*)getCategory:(id)jcategory
{
    NSDictionary* jcate = jcategory;
    NSString* cid = jcate[@"$id"];
    NSInteger popular = [(NSString*)jcate[@"Hot"] integerValue];
    NSString* name = jcate[@"Name"];
    mqyyCategory* category = [[mqyyCategory alloc]initWithName:name popular:popular id:cid];
    NSInteger programCnt = [(NSString*)jcate[@"Sum"] integerValue];
    for (NSInteger ix = 0; ix < programCnt; ++ix) {
        [category addProgram:[[mqyyProgram alloc] init]];
    }
    return category;
}

-(mqyyCategory*)syncFillCategory:(mqyyCategory*)category
{
    //NSString* param = [NSString stringWithFormat:@"Category/%@", [category cid]];
    ///缺个接口， 这先用所有program来搞么
    NSString* param = [NSString stringWithFormat:@"Work"];
    NSArray* jdata = [self syncGet:param];
    [category clearProgram];
    for(NSInteger ix = 0; ix < jdata.count; ++ix){
        [category addProgram:[self getProgram:[jdata objectAtIndex:ix]]];
    }
    return category;
}

-(mqyyProgram*)getProgram:(id)jprogram_
{
    NSDictionary*jprogram  = jprogram_;
    NSString* pid = jprogram[@"$id"];
    NSInteger popular = [(NSString*)jprogram[@"Hot"] integerValue];
    NSString* name = jprogram[@"Name"];
    NSString* brief = jprogram[@"Breif"];
    NSString* readerId = jprogram[@"AnnouncerId"];
    mqyyUser* reader = [[mqyyUser alloc]initWithId:readerId];
    reader = [self syncFillUser:reader];
    enum mqyyProgramState state = [(NSNumber*)jprogram[@"Status"] integerValue];
    
    mqyyProgram* program = [[mqyyProgram alloc] initWithName:name popular:popular id:pid brief:brief reader:reader state:state conforms:[self getUserConforms:jprogram_]];
    NSInteger sectionCnt = [(NSString*)jprogram[@"SectionSum"] integerValue];
    for (NSInteger ix = 0; ix < sectionCnt; ++ix) {
         ///同样缺个接口， 这先用index来做为id试试
        NSString* sid = [NSString stringWithFormat:@"%d",ix + 1];
        [program addSection:[[mqyySection alloc] initWithId:sid index:ix]];
    }
    return program;
}

-(mqyyUserConforms*)getUserConforms:(id)jprogram_
{
    NSDictionary*jprogram  = jprogram_;
    float rate = [(NSNumber*)jprogram[@"CommentLv"] floatValue];
    ///comment id ? 用program id 试试
    NSString* pid = jprogram[@"$id"];
    NSInteger conformCnt = [(NSNumber*)jprogram[@"CommentSum"] integerValue];
    mqyyUserConforms* conforms = [[mqyyUserConforms alloc]initWithId:pid rate:rate];
    for (NSInteger ix = 0; ix < conformCnt; ++ix) {
        [conforms addConform:[[mqyyUserConform alloc]init]];
    }
    return conforms;
}

-(mqyyProgram*)syncFillProgram:(mqyyProgram*)program
{
    //NSString* param = [NSString stringWithFormat:@"Work/%@",program.pid];
    for(NSInteger ix = 0;ix < program.sections.count; ++ix)
    {
        mqyySection* labelSection = (mqyySection*)[program.sections objectAtIndex:ix];
        [self syncFillSection:labelSection];
    }
    return program;
}

-(mqyySection*)syncFillSection:(mqyySection*)section
{
    NSString* param = [NSString stringWithFormat:@"Section/%@",section.sid];
    NSDictionary* jsection = [self syncGet:param];
    NSString* name = jsection[@"Name"];
    //? content的url咋访问么?
    NSString* url = [[NSString alloc]initWithFormat:_apiUrlFormat, jsection[@"Content"]];
    return [section initWithName:name url:url index:section.index];
}

-(mqyySection*)syncNewSection:(mqyySection*)section
{
    NSDictionary* header = [[NSDictionary alloc]initWithObjectsAndKeys:@"multipart/form-data",@"Content-Type",nil];
    NSData* body = [[NSData alloc]initWithContentsOfFile:section.url];
    NSArray* jobj = [self syncPost:@"Section" header:header body:body];
    ////解析返回填充section
    (void)jobj;
    
    return section;
}

-(mqyyUser*)syncFillUser:(mqyyUser*)user
{
    NSString* param = [NSString stringWithFormat:@"User/%@",user.uid];
    NSDictionary* juser = [self syncGet:param];
   
    return user;
}

-(mqyyUserConforms*)syncFillConforms:(mqyyUserConforms*)conforms
{
    
}

-(mqyyUserConform*)syncFillConform:(mqyyUserConform*)conform
{
    
}


@end
