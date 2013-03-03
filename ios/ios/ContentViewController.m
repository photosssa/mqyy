//
//  ContentViewController.m
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "ContentViewController.h"
#import "mqyyClient.h"
#import "BriefViewController.h"
#import "UserConformsViewController.h"

@interface ContentViewController ()
{
    @private
    NSString* _sectionCellId;// = @"SectionCell";
    NSString* _ctrlXibId;//= @"Controls_iPhone"
    mqyyProgram* _program;
    NSInteger _curPage;
    NSArray* _sectionCells;
}

@end

@implementation ContentViewController

@synthesize program = _program;
@synthesize SectionNavNextBtn, SectionNavPreBtn, sectionNumLabel;

-(void)fillData:(mqyyProgram*)program
{
    _program = program;
    
}

-(SectionTableViewCell*)sectionCell:(NSInteger)index
{
    if(_sectionCells == nil){
        _sectionCells = [[NSMutableArray alloc] init];
        for(int ix = 0; ix < 3; ++ix)
        {
            NSIndexPath* cellIndex = [NSIndexPath indexPathForRow:ix inSection:1];
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:_sectionCellId forIndexPath:cellIndex];
            [(NSMutableArray*)_sectionCells addObject:cell];
        }
    }
    return [_sectionCells objectAtIndex:index];
}

-(void)navigateSectionPage:(NSInteger)page
{
    if(page < 0)
    {
        return ;
    }
    NSInteger pageCount = [self.program.sections count] / 3 + ([self.program.sections count] % 3 ? 1 : 0) ;
    if(page > pageCount - 1)
    {
        return ;
    }
    _curPage = page;
    self.SectionNavPreBtn.hidden = YES;
    self.SectionNavNextBtn.hidden = YES;
    if(_curPage  > 0)
    {
        SectionNavPreBtn.hidden = NO;
    }
    if(_curPage < pageCount - 1)
    {
        SectionNavNextBtn.hidden = NO;
    }
    self.sectionNumLabel.text = [NSString stringWithFormat:@"当前第%d页／总%d页",_curPage + 1, pageCount ];
    for(NSInteger ix = 0;ix < 3; ++ix)
    {
        SectionTableViewCell* cell = [self sectionCell:ix];
        NSInteger sectionIndex = _curPage * 3 + ix;
        if(sectionIndex < [self.program.sections count]){
            [cell fillData:[self.program.sections objectAtIndex:sectionIndex]];

        }
        else{
            [cell fillData:nil];
        }
    }

    
}

-(void)navigateSection:(NSInteger)index
{
    NSInteger page = index / 3;
    [self navigateSectionPage:page];
 }


-(void) viewWillDisappear:(BOOL)animated
{
     [[mqyyClient clientInstance] hidePlayToolbar];
    [super viewWillDisappear:animated];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[mqyyClient clientInstance] showPlayToolbar];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _sectionCellId = @"SectionCell";
    _ctrlXibId = @"SectionCell";

    UINib *nib = [UINib nibWithNibName:_ctrlXibId bundle:nil];
    
    [(UITableView*)self.view registerNib:nib forCellReuseIdentifier:_sectionCellId];
    
    [UserConformTableViewCell registerInTableview:(UITableView*)self.view];
    
    self.navigationItem.title = self.program.name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"缓存全部" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self navigateSectionPage:0];
    
    //[self.navigationController  setToolbarHidden:YES animated:YES];
    
    

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
    if(indexPath.section == 1)
    {
        if(indexPath.row < 3){
            return [self sectionCell:indexPath.row];
        }
    }
    else if(indexPath.section == 0){
        if(indexPath.row == 1){
            UserConformTableViewCell* userConformCell = (UserConformTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[UserConformTableViewCell identifier]];
            [userConformCell fillData:self.program.conforms from:self];
            return userConformCell;
        }
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

//#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.section == 1) {
        if(indexPath.row < 3){
            SectionTableViewCell* cell = (SectionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            [cell didSelected];
        }
    }
    else if(indexPath.section == 0){
        if(indexPath.row == 1){
            UserConformTableViewCell* userConformCell = (UserConformTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            [userConformCell didSelected];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowBrief"]){
        BriefViewController* briefView = (BriefViewController*)[segue destinationViewController];
        [briefView fillData:self.program];
    }
    else if([[segue identifier] isEqualToString:@"ShowConformContent"]){
        UserConformsViewController* conformView = [segue destinationViewController];
        [conformView fillData:self.program.conforms];
    }

    
        
}

- (IBAction)SectionNavNext:(id)sender {
    [self navigateSectionPage:_curPage + 1];
}

- (IBAction)SectionNavPre:(id)sender {
    [self navigateSectionPage:_curPage - 1];
}
@end


@interface SectionTableViewCell()
{
    @private
    mqyySection* _section;
}

@end

@implementation SectionTableViewCell

@synthesize nameLabel,cacheStateBtn, section=_section;

-(void)fillData:(mqyySection*)section
{
    _section = section;
    if(section != nil)
    {
        self.nameLabel.hidden = NO;
        self.cacheStateBtn.hidden = NO;
        self.nameLabel.text = self.section.name;
        self.cacheStateBtn.enabled = !section.cached;
        [self.cacheStateBtn setTitle:@"已缓存" forState:UIControlStateDisabled];
        //self.cacheStateBtn.titleLabel.text = section.cached ? @"已缓存" : @"缓存";
    }
    else{
        self.nameLabel.hidden = YES;
        self.cacheStateBtn.hidden = YES;
    }
}

- (IBAction)onCache:(id)sender {
    [[[mqyyClient clientInstance] filesystem] syncSectionURL:_section];
    [self fillData:_section];
}

- (void)setSelected:(BOOL)selected
{
    return [super setSelected:selected];
}

- (void)didSelected
{
    [self fillData:_section];
    [[mqyyClient clientInstance] playSection:_section];
}
@end






