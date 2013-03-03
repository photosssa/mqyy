//
//  mayyClient.h
//  ios
//
//  Created by Tsukasa on 13-1-26.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Data.h"
#import "mqyyServerStub.h"





@protocol mqyyAudioDelegate 
-(void)finishSection;
-(void)playProgress:(float)progress;
@end

@interface mqyyAudio : NSObject<AVAudioPlayerDelegate>
@property(retain) id<mqyyAudioDelegate> delegate;

-(BOOL)playUrl:(NSURL*)url;
-(void)pause;
-(void)resume;
-(BOOL)recodeOnUrl:(NSURL*)url;
-(NSURL*)finishRecode;
-(void)stopRecode;
@end


@interface mqyyFileSystem : NSObject
-(NSURL*)syncSectionURL:(mqyySection*)section;
-(BOOL)isSectionCached:(mqyySection*)section;
@end


@protocol PlayToolbarViewDelegate;

@interface PlayToolbarView : UIControl
- (IBAction)onNext:(id)sender;
- (IBAction)onPre:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
- (void)setPlayState:(BOOL)play Section:(mqyySection*)section;
- (void)setPlayProgress:(float)progress;
- (IBAction)onPlayPause:(id)sender;
@property (retain) id<PlayToolbarViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *progressBar;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;

@end


@protocol PlayToolbarViewDelegate
-(void) PlayToolbarNext:(PlayToolbarView*)playToolbar;
-(void) PlayToolbarPre:(PlayToolbarView*)playToolbar;
-(void) PlayToolbarPlay:(PlayToolbarView*)playToolbar;
-(void) PlayToolbarPause:(PlayToolbarView*)playToolbar;
@end


@protocol RecodeToolbarViewDelegate;

@interface RecodeToolbarView : UIControl
- (IBAction)onRec:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recBtn;
@property (retain) id<RecodeToolbarViewDelegate> delegate;
-(void)setEnterRecordView:(BOOL)enterRecordView;
@end

@protocol RecodeToolbarViewDelegate
-(void)startRecode:(RecodeToolbarView*)recodeToolbar;
-(void)finishRecode:(RecodeToolbarView*)recodeToolbar;
-(void)stopRecode:(RecodeToolbarView*)recodeToolbar;
-(void)saveRecode:(RecodeToolbarView*)recodeToolbar;
@end


@interface mqyyClient : NSObject <PlayToolbarViewDelegate, mqyyAudioDelegate, RecodeToolbarViewDelegate>
+(mqyyClient*) clientInstance;
-(mqyyClient*) init;
-(void) playSection:(mqyySection*)section;
@property(strong) mqyyAudio* audio;
@property(strong) mqyyServerStub* svrstub;
@property(strong) mqyyFileSystem* filesystem;
-(void)showPlayToolbar;
-(void)hidePlayToolbar;
-(void)showRecodeToolbar;
-(void)hideRecodeToolbar;
-(RecodeToolbarView*)getRecodeToolbar;
@end
