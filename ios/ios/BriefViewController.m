//
//  BriefViewController.m
//  ios
//
//  Created by Tsukasa on 13-1-26.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "BriefViewController.h"
#import "ContentViewController.h"
#import "UserConformsViewController.h"

@interface BriefViewController ()

@end

@implementation BriefViewController
{
    @private
    mqyyProgram* _program;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)fillData:(mqyyProgram*)program
{
    _program = program;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = _program.name;
    self.readerLabel.text = _program.reader.name;
    self.popularLabel.text = [NSString stringWithFormat:@"%d",_program.popular];
    self.sectionsLabel.text = [NSString stringWithFormat:@"%d",_program.sections.count];
    self.briefLabel.text = _program.brief;
    if (_program.state == mqyyProgramStateOver) {
        self.statLabel.text = @"完结";
    }
    [UserConformTableViewCell registerInTableview:(UITableView*)self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UserConformTableViewCell* userConformCell = (UserConformTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[UserConformTableViewCell identifier]];
        [userConformCell fillData:_program.conforms from:self];
        return userConformCell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
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
//
//#pragma mark - Table view delegate
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.row == 1) {
        UserConformTableViewCell* userConformCell = (UserConformTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        [userConformCell didSelected];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowProgram"]) {
        ContentViewController* contentView = (ContentViewController*)[segue destinationViewController];
        [contentView fillData:_program];
    }
    else if([[segue identifier] isEqualToString:@"ShowConformContent"]){
        UserConformsViewController* conformView = [segue destinationViewController];
        [conformView fillData:_program.conforms];
    }
}


@end
