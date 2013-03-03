//
//  RecordeViewController.m
//  ios
//
//  Created by Tsukasa on 13-2-5.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "RecordeViewController.h"
#import "mqyyClient.h"

@interface RecordeViewController ()

@end

@implementation RecordeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[[mqyyClient clientInstance] getRecodeToolbar] setEnterRecordView:NO];
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[mqyyClient clientInstance] getRecodeToolbar] setEnterRecordView:YES];
}

@end
