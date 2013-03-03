//
//  UserConfromsViewController.h
//  ios
//
//  Created by Tsukasa on 13-2-5.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface UserConformsViewController : UITableViewController
-(void) fillData:(mqyyUserConforms*)conform;

@end


@interface UserConformContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *userRateLayout;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

-(void) fillData:(mqyyUserConform*)conform;
@end



@interface UserRateCtrl : UIControl
@property (weak, nonatomic) IBOutlet UIImageView *starImg4;
@property (weak, nonatomic) IBOutlet UIImageView *starImg3;
@property (weak, nonatomic) IBOutlet UIImageView *starImg2;
@property (weak, nonatomic) IBOutlet UIImageView *starImg1;
@property (weak, nonatomic) IBOutlet UIImageView *starImg0;
+(UserRateCtrl*)newInstance;

-(void)setRate:(float)rate;
@end


@interface UserConformTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *userRateLayout;
@property (weak, nonatomic) IBOutlet UILabel *conformCountLabel;
+(void)registerInTableview:(UITableView*)tableView;
+(NSString*)identifier;
-(void)fillData:(mqyyUserConforms*)conforms from:(UIViewController*)controller;
-(void)didSelected;
@end