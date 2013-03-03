//
//  mayyClient.m
//  ios
//
//  Created by Tsukasa on 13-1-26.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "mqyyClient.h"
#import "AppDelegate.h"
#import "UITestData.h"




@interface mqyyAudio()
{
    @private
    AVAudioPlayer* _player;
    NSTimer* _timer;
    AVAudioRecorder* _recorder;
    NSURL* _recodingUrl;
    //AVAudioSession* _audioSession;
}

@end

@implementation mqyyAudio
@synthesize delegate;

-(void)playTimer
{
    [[self delegate]playProgress:([_player currentTime] / [_player duration])];
}
-(void)starPlayTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playTimer) userInfo:nil repeats:YES];
}
-(void)stopPlayTimer
{
    [_timer invalidate];
    _timer = nil;
}
-(BOOL)playUrl:(NSURL*)url
{
    NSError* error;
//    NSURL* fileUrl = [mqyyFileSystem syncSectionURL:nil];
   if(_player != nil)
   {
       [_player stop];
   }
    
    BOOL ret = [[AVAudioSession sharedInstance] setActive: YES error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }

    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.delegate = self;
    NSString* errStr = [error localizedDescription];
    NSLog(errStr);
//    errStr = [error localizedFailureReason];
    BOOL bret = [_player play];
    [self starPlayTimer];
    return bret;
}

-(void)pause
{
    [_player pause];
    [self stopPlayTimer];
}
-(void)resume
{
    [_player play];
    [self starPlayTimer];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopPlayTimer];
    NSError* error ;
    BOOL ret = [[AVAudioSession sharedInstance] setActive: NO error:&error];
    if (!ret) {
        NSLog(@"%@", error.description);
    }
    
    [[self delegate]finishSection];
}

-(BOOL)recodeOnUrl:(NSURL*)url
{
    if(_recorder != nil){
        [_recorder stop];
    }
    
    
    NSError* error;
    BOOL ret = [[AVAudioSession sharedInstance]setCategory: AVAudioSessionCategoryRecord error: &error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    ret = [[AVAudioSession sharedInstance] setActive: YES error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    
    NSDictionary *recordSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
     [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
     [NSNumber numberWithInt: AVAudioQualityMax],
     AVEncoderAudioQualityKey,
     nil];
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSettings error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    _recodingUrl = url;
    
    
    return [_recorder record];
}

-(NSURL*)finishRecode
{
    [_recorder stop];
    _recorder = nil;
    NSError* error;
    BOOL ret = [[AVAudioSession sharedInstance] setActive:NO error:&error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    ret = [[AVAudioSession sharedInstance]setCategory: AVAudioSessionCategoryPlayback error: &error];
    if (error) {
        NSLog(@"%@", error.description);
    }
    
    NSURL* url = _recodingUrl;
    _recodingUrl = nil;
    return url;
}

-(void)stopRecode
{
    AVAudioRecorder* recorder = _recorder;
    [self finishRecode];
    [recorder deleteRecording];
}

@end


@implementation mqyyFileSystem

-(NSURL*)syncSectionURL:(mqyySection*)section
{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* asUrls = [fileMgr URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    NSURL* asUrl = [asUrls objectAtIndex:0];
//    NSString* asPath = asUrl.path;
    NSString* rDicPath = [NSString stringWithFormat:@"audiocaches/%@",section.program.name];
    NSString* rFileName = [NSString stringWithFormat:@"%@.mp3", section.name];
    NSURL* aDicUrl = [asUrl URLByAppendingPathComponent:rDicPath isDirectory:YES];
    NSURL* aFileUrl = [aDicUrl URLByAppendingPathComponent:rFileName];
    if(![fileMgr fileExistsAtPath:aFileUrl.path]){
        NSError* fsErr = nil;
        BOOL fsRet = [fileMgr createDirectoryAtPath:aDicUrl.path withIntermediateDirectories:YES attributes:nil error:&fsErr];
        NSURL* httpUrl = [NSURL URLWithString:section.url];
        NSData* audiodata = [[NSData alloc]initWithContentsOfURL:httpUrl];
        fsRet = [audiodata writeToFile:aFileUrl.path atomically:YES];
    }
    section.cached = YES;
    return aFileUrl;
}

-(BOOL)isSectionCached:(mqyySection*)section
{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* asUrls = [fileMgr URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    NSURL* asUrl = [asUrls objectAtIndex:0];
    //    NSString* asPath = asUrl.path;
    NSString* rDicPath = [NSString stringWithFormat:@"audiocaches/%@",section.program.name];
    NSString* rFileName = [NSString stringWithFormat:@"%@.mp3", section.name];
    NSURL* aDicUrl = [asUrl URLByAppendingPathComponent:rDicPath isDirectory:YES];
    NSURL* aFileUrl = [aDicUrl URLByAppendingPathComponent:rFileName];
    return [fileMgr fileExistsAtPath:aFileUrl.path];
}

-(NSURL*)tempRecordURL
{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* asUrls = [fileMgr URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];

    NSURL* asUrl = [asUrls objectAtIndex:0];
    NSString* rFileName = [NSString stringWithFormat:@"%@.cab", [[[NSDate alloc]init]description]];
    NSURL* aFileUrl = [asUrl URLByAppendingPathComponent:rFileName];

//    int ttt[50] = {0};
//    NSData* tt = [[NSData alloc]initWithBytes:ttt length:50 * sizeof(int)];
//    BOOL ret = [fileMgr createFileAtPath:aFileUrl.path contents:tt attributes:nil];
    return aFileUrl;
}

@end





@implementation mqyyClient
{
@private
    PlayToolbarView* _playToolbar;
    mqyySection* _playingSection;
    RecodeToolbarView* _recodeToobar;
    BOOL _recodeToolbarShowing;
    mqyySection* _toUploadSection;
}


@synthesize filesystem, svrstub, audio;

+(mqyyClient*) clientInstance
{
   return ((AppDelegate*)([UIApplication sharedApplication].delegate)).client;
}

-(mqyyClient*) init
{
    audio = [[mqyyAudio alloc] init];
    audio.delegate = self;
    filesystem = [[mqyyFileSystem alloc] init];
    svrstub = [[mqyyServerStub alloc] init];
    //svrstub = [[UITestDataStub alloc] init];
    _recodeToolbarShowing = NO;
   
    return self;
}

-(void) playSection:(mqyySection*)section
{
    _playingSection = section;
    if(section == nil)
    {
        return ;
    }
    NSURL* url = [[[mqyyClient clientInstance] filesystem] syncSectionURL:section];
    
    [[self audio] playUrl:url];
    [[self getPlayToolbar] setPlayState:YES Section:section];
    [[self getPlayToolbar] setPlayProgress:0];
}

-(void) PlayToolbarNext:(PlayToolbarView*)playToolbar
{
    [self playSection:[_playingSection nextSection]];
}
-(void) PlayToolbarPre:(PlayToolbarView*)playToolbar
{
     [self playSection:[_playingSection preSection]];
}
-(void) PlayToolbarPlay:(PlayToolbarView*)playToolbar
{
    [[self audio] resume];
}
-(void) PlayToolbarPause:(PlayToolbarView*)playToolbar
{
    [[self audio] pause];
}

-(PlayToolbarView*) getPlayToolbar
{
    if (_playToolbar == nil) {
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"PlayToolbar" owner:self options:nil];
        _playToolbar = [nibViews objectAtIndex:0];
        _playToolbar.delegate = self;
        UIWindow* thisWindow = [UIApplication sharedApplication].keyWindow;
        _playToolbar.frame = CGRectMake(0.0, thisWindow.frame.size.height - _playToolbar.frame.size.height, _playToolbar.frame.size.width, _playToolbar.frame.size.height);
        //_toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _playToolbar;
}



-(void)showPlayToolbar
{
    [self hideRecodeToolbar];
    [self getPlayToolbar];
    UIWindow* thisWindow = [UIApplication sharedApplication].keyWindow;
    [thisWindow addSubview:_playToolbar];
}
-(void)hidePlayToolbar
{
    [self getPlayToolbar];
    [_playToolbar removeFromSuperview];
    [self showRecodeToolbar];
}

-(void)finishSection
{
    [self playSection:[_playingSection nextSection]];
}

-(void)playProgress:(float)progress
{
    [[self getPlayToolbar]setPlayProgress:progress];
}

-(RecodeToolbarView*) getRecodeToolbar
{
    if (_recodeToobar == nil) {
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"RecodeToolbar" owner:self options:nil];
        _recodeToobar = [nibViews objectAtIndex:0];
        _recodeToobar.delegate = self;
        UIWindow* thisWindow = [UIApplication sharedApplication].keyWindow;
        _recodeToobar.frame = CGRectMake(0.0, thisWindow.frame.size.height - _recodeToobar.frame.size.height, _recodeToobar.frame.size.width, _recodeToobar.frame.size.height);
        //_toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _recodeToobar;
}

-(void)showRecodeToolbar
{
    if(!_recodeToolbarShowing){
        [self getRecodeToolbar];
        UIWindow* thisWindow = [UIApplication sharedApplication].keyWindow;
        [thisWindow addSubview:_recodeToobar];
        _recodeToolbarShowing = YES;
    }
}
-(void)hideRecodeToolbar
{
    if (_recodeToolbarShowing) {
        [self getRecodeToolbar];
        [_recodeToobar removeFromSuperview];
        _recodeToolbarShowing = NO;
    }
}

-(void)startRecode:(RecodeToolbarView*)recodeToolbar
{
    NSURL* tempUrl = [[self filesystem]tempRecordURL];
    [[self audio] recodeOnUrl:tempUrl];
}

-(void)finishRecode:(RecodeToolbarView*)recodeToolbar
{
    NSURL* url = [[self audio] finishRecode];
    _toUploadSection = [[mqyySection alloc]initWithName:nil url:url.path index:0];
}

-(void)saveRecode:(RecodeToolbarView*)recodeToolbar
{
    ///upload _toUploadSection
    [self.svrstub syncNewSection:_toUploadSection];
    _toUploadSection = nil;
}

-(void)stopRecode:(RecodeToolbarView *)recodeToolbar
{
    [[self audio] stopRecode];
}


@end

@interface PlayToolbarView ()
{
    @private
    UIImage* _playImage;
    UIImage* _pauseImage;
    BOOL _playState;
}
@end

@implementation PlayToolbarView

@synthesize progressBar,playBtn,nextBtn,preBtn, sectionLabel;

- (void)innerSetPlayState:(BOOL)play
{
    if(!play){
        if(_playImage == nil){
            NSString* imageName = [[NSBundle mainBundle] pathForResource:@"ButtonPlayNormal" ofType:@"png"];
            _playImage = [[UIImage alloc]initWithContentsOfFile:imageName];
        }
        [playBtn setImage:_playImage forState:UIControlStateNormal];
        _playState = FALSE;
    }
    else{
        if(_pauseImage == nil){
            NSString* imageName = [[NSBundle mainBundle] pathForResource:@"ButtonPauseNormal" ofType:@"png"];
            _pauseImage = [[UIImage alloc]initWithContentsOfFile:imageName];
        }
        [playBtn setImage:_pauseImage forState:UIControlStateNormal];
        _playState = TRUE;
    }
}

- (void)setPlayState:(BOOL)play Section:(mqyySection*)section 
{
    NSString* sectionDisplay = [NSString stringWithFormat:@"%@-%@",section.program.name,section.name];
    [self sectionLabel].text = sectionDisplay;
    [self innerSetPlayState:play];
}

- (void)setPlayProgress:(float)progress
{
    [progressBar setValue:progress animated:TRUE];
}



- (IBAction)onPlayPause:(id)sender {
    [self innerSetPlayState:(!_playState)];
    if(_playState){
        [[self delegate] PlayToolbarPlay:self];
    }
    else{
        [[self delegate] PlayToolbarPause:self];
    }
}
- (IBAction)onNext:(id)sender {
    [[self delegate] PlayToolbarNext:self];
}

- (IBAction)onPre:(id)sender {
    [[self delegate] PlayToolbarPre:self];
}
@end


enum RecodeToolbarViewState {
    RecodeToolbarViewStatePrepare,
    RecodeToolbarViewStateRecording,
    RecodeToolbarViewStateFinish,
}; 

@implementation RecodeToolbarView
{
    @private
    UIImage* _startRecodeImg;
    UIImage* _recordingImg;
    UIImage* _enterRecodeImg;
    UIImage* _finishRecodeImg;
    enum RecodeToolbarViewState _recordingState;
    BOOL _enterRecodeView;
}
@synthesize recBtn, delegate;
-(RecodeToolbarView*)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    _recordingState = RecodeToolbarViewStatePrepare;
    _enterRecodeView = NO;
    return self;
}

-(UIImage*)getStartRecodeImg
{
    if(_startRecodeImg == nil)
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"ButtonRecNormal" ofType:@"png"];
        _startRecodeImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _startRecodeImg;
}

-(UIImage*)getRecordingImg
{
    if(_recordingImg == nil)
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"PicRecStatusRecing" ofType:@"png"];
        _recordingImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _recordingImg;

}


-(UIImage*)getFinishRecodeImg
{
    if(_finishRecodeImg == nil)
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"ButtonFinishNormal" ofType:@"png"];
        _finishRecodeImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _finishRecodeImg;
}



-(UIImage*)getEnterRecodeImg
{
    if(_enterRecodeImg == nil)
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"ButtonRecModeNormal" ofType:@"png"];
        _enterRecodeImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _enterRecodeImg;
    
}


-(void)resetButton
{
    if(!_enterRecodeView){
       [self.recBtn setImage:[self getEnterRecodeImg] forState:UIControlStateNormal];
    }
    else{
        if(_recordingState == RecodeToolbarViewStateFinish){
            [self.recBtn setImage:[self getFinishRecodeImg] forState:UIControlStateNormal];
        }
        else if(_recordingState == RecodeToolbarViewStateRecording){
            [self.recBtn setImage:[self getRecordingImg] forState:UIControlStateNormal];
        }
        else if(_recordingState == RecodeToolbarViewStatePrepare){
            [self.recBtn setImage:[self getStartRecodeImg] forState:UIControlStateNormal];
        }
    }
}

-(void)setEnterRecordView:(BOOL)enterRecordView
{
    _enterRecodeView = enterRecordView;
    if(_recordingState == RecodeToolbarViewStateRecording && !_enterRecodeView)
    {
        [[self delegate]stopRecode:self];
    }
    
    _recordingState = RecodeToolbarViewStatePrepare;
    [self resetButton];
}





- (IBAction)onRec:(id)sender {
    if(!_enterRecodeView){
        UINavigationController* navCtrl = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        UIStoryboard* storyBoard = navCtrl.storyboard;
        UIViewController* dest = [storyBoard instantiateViewControllerWithIdentifier:@"RecordeView"];
        [navCtrl pushViewController:dest animated:YES];
        _enterRecodeView = YES;
    }
    else{
        if(_recordingState == RecodeToolbarViewStatePrepare){
            _recordingState = RecodeToolbarViewStateRecording;
            [delegate startRecode:self];
        }
        else if(_recordingState == RecodeToolbarViewStateRecording){
            _recordingState = RecodeToolbarViewStateFinish;
            [delegate finishRecode:self];
        }
        else if(_recordingState == RecodeToolbarViewStateFinish){
            _recordingState = RecodeToolbarViewStatePrepare;
            [delegate saveRecode:self];
        }
    }
    [self resetButton];
}
@end
