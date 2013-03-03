//
//  UserConfromsViewController.m
//  ios
//
//  Created by Tsukasa on 13-2-5.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "UserConformsViewController.h"

@interface UserConformsViewController ()
{
    @private
    mqyyUserConforms* _conforms;
}
@end

@implementation UserConformsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) fillData:(mqyyUserConforms*)conform
{
    _conforms = conform;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[_conforms conforms] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserConformContentCell";
    UserConformContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell fillData:[_conforms.conforms objectAtIndex:indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end


@implementation UserConformContentCell
{
    @private
    UserRateCtrl* _userRateCtrl;
}
@synthesize userRateLayout, userLabel, contentLabel;
-(void) fillData:(mqyyUserConform*)conform
{
    if(_userRateCtrl == nil)
    {
        _userRateCtrl = [UserRateCtrl newInstance];
        [[self userRateLayout] addSubview:_userRateCtrl];
    }
   
    [_userRateCtrl setRate: [conform rate]];
    userLabel.text = [[conform user] name];
    contentLabel.text = [conform comment];
}
@end


@implementation UserRateCtrl
{
@private
    UIImageView* _starImgs[5];
    UIImage* _fullStarImg;
    UIImage* _halfStarImg;
    UIImage* _emptyStarImg;
}

@synthesize starImg0, starImg1, starImg2, starImg3, starImg4;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

+(UserRateCtrl*)newInstance
{
    NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"UserRate" owner:self options:nil];
    return [nibViews objectAtIndex:0];
}


-(UIImage*)fullStarImg
{
    if(_fullStarImg == nil){
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"PicStarFull" ofType:@"png"];
        _fullStarImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _fullStarImg;
}

-(UIImage*)halfStarImg
{
    if(_halfStarImg == nil){
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"PicStarHalf" ofType:@"png"];
        _halfStarImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _halfStarImg;
}

-(UIImage*)emptyStarImg
{
    if(_emptyStarImg == nil){
        NSString* imageName = [[NSBundle mainBundle] pathForResource:@"PicStarEmpty" ofType:@"png"];
        _emptyStarImg = [[UIImage alloc]initWithContentsOfFile:imageName];
    }
    return _emptyStarImg;
}

-(UIImageView*)starAtIndex:(NSInteger)index
{
    if(_starImgs[0] == nil)
    {
        _starImgs[0] = starImg0;
        _starImgs[1] = starImg1;
        _starImgs[2] = starImg2;
        _starImgs[3] = starImg3;
        _starImgs[4] = starImg4;
    }
    return _starImgs[index];
}

-(void)setRate:(float)rate
{
    NSInteger dRate = rate;
    for(NSInteger ix = 0;ix < dRate; ++ix){
        [self starAtIndex:ix].image = [self fullStarImg];
    }
    if(dRate == 5){
        return ;
    }
    float iRate = rate - dRate;
    if(iRate >= 0.5){
        [self starAtIndex:dRate].image = [self halfStarImg];
    }
    else{
        [self starAtIndex:dRate].image = [self emptyStarImg];
    }
    for(NSInteger ix=dRate+1;ix < 5;++ix)
    {
        [self starAtIndex:ix].image = [self emptyStarImg];
    }
}


@end


@implementation UserConformTableViewCell
{
@private
    UserRateCtrl* _userRateCtrl;
    UIViewController* _controller;
}
@synthesize conformCountLabel, userRateLayout;
+(void)registerInTableview:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"UserConformCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:[UserConformTableViewCell identifier]];
    
}

+(NSString*)identifier
{
    return @"UserConformCell";
}



-(void)willMoveToSuperview:(UIView *)newSuperview
{
    return [super willMoveToSuperview:newSuperview];
}



-(void)setRate:(float)rate
{
    if(_userRateCtrl == nil){
        _userRateCtrl = [UserRateCtrl newInstance];
        [self.userRateLayout addSubview:_userRateCtrl];
    }
    [_userRateCtrl setRate:rate];
}

-(void)fillData:(mqyyUserConforms*)conforms  from:(UIViewController*)controller
{
    [self setRate:[conforms rate]];
    self.conformCountLabel.text = [NSString stringWithFormat:@"%d份评论",[[conforms conforms] count]];
    _controller = controller;
}

-(void)didSelected
{
    [_controller performSegueWithIdentifier:@"ShowConformContent" sender:self];
}

@end
