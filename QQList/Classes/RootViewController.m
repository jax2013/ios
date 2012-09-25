//
//  RootViewController.m
//  China36Plans
//
//  Created by apple on 10-10-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize titles;
@synthesize detailView;
@synthesize dic;



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的QQ";
	UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bgd.jpg"]];
	self.tableView.backgroundColor = color;
	[color release];
	
	NSArray *array = [NSArray arrayWithObjects:@"我的好友",
					  @"我的同事",
					  @"我的妹妹",
					  @"我的兄弟",
					  @"我的粉丝",
					  @"黑名单",
					  nil];
	self.titles = array;
	
	flag = (BOOL*)malloc(sizeof(BOOL*));
	memset(flag, NO, sizeof(flag)*[self.titles count]);
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path]; 
	self.dic = dict;
	[dict release];
	
	
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	UIButton *bButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	bButton.frame = CGRectMake(280, 12, 20, 20);
	bButton.tag = 9;
	[bButton addTarget:self action:@selector(toInfo) forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.navigationBar addSubview:bButton];
}

- (void)viewWillDisappear:(BOOL)animated {
	UIButton *bButton = (UIButton *)[self.navigationController.navigationBar viewWithTag:9];
    [bButton removeFromSuperview];
}


-(void)toInfo{
	UIButton *bButton = (UIButton *)[self.navigationController.navigationBar viewWithTag:9];
	
	if(bButton != nil){
		
		
		self.tableView.userInteractionEnabled = NO;
		UIImageView *infoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
		infoImage.image = [UIImage imageNamed:@"info.png"];
		infoImage.tag = 10;
		[UIView beginAnimations:@"animation" context:nil];
		[UIView setAnimationDuration:1.0f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationRepeatAutoreverses:NO];
		[self.view addSubview:infoImage];
		self.title = @"信息";
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
		[UIView commitAnimations];
		[infoImage release];
		
		[bButton removeFromSuperview];
		
		UIBarButtonItem *next = [[[UIBarButtonItem alloc] 
								  initWithTitle: @"OK"
								  style:UIBarButtonItemStylePlain
								  target: self
								  action: @selector(toInfo)]
								 autorelease];
		self.navigationItem.rightBarButtonItem = next;	
	}
	else {
		self.tableView.userInteractionEnabled = YES;
		self.navigationItem.rightBarButtonItem = nil;
		[UIView beginAnimations:@"animation" context:nil];
		[UIView setAnimationDuration:1.0f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationRepeatAutoreverses:NO];
		UIImageView *image = (UIImageView *)[self.view viewWithTag:10];
		[image removeFromSuperview];
		self.title = @"我的QQ";
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
		[UIView commitAnimations];
		UIButton *bButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		bButton.frame = CGRectMake(280, 12, 20, 20);
		bButton.tag = 9;
		[bButton addTarget:self action:@selector(toInfo) forControlEvents:UIControlEventTouchUpInside];
		[self.navigationController.navigationBar addSubview:bButton];
		
	}
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.titles count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:section];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	int section = [indexPath section];
	int row = [indexPath row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if(row>1)
	   cell.imageView.image = [UIImage imageNamed:@"unOnline.png"];
	else 
		cell.imageView.image = [UIImage imageNamed:@"online.png"];
	NSDictionary *source = [self.dic objectForKey:[NSString stringWithFormat:@"%i",section+1]];
	NSArray *array = [source objectForKey:@"titles"];
	
	UILabel *label = (UILabel *)[cell viewWithTag:7];
	if(label){
		label.text = [array objectAtIndex:row];

	}
	else {
		UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0,260, 30)];
		secondLabel.font = [UIFont systemFontOfSize:14];
		secondLabel.backgroundColor = [UIColor clearColor];
		secondLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.3 alpha:1];
		secondLabel.text = [array objectAtIndex:row];
		secondLabel.tag = 7;
		[cell addSubview:secondLabel];
		[secondLabel release];
		
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 40;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 50;
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.tag = section;
	NSDictionary *source = [self.dic objectForKey:[NSString stringWithFormat:@"%i",section+1]];
	NSArray *array = [source objectForKey:@"titles"];
	[button setBackgroundImage:[UIImage imageNamed:@"bgd1.png"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
	
	if(flag[section])
		image.image = [UIImage imageNamed:@"normal.png"];
	else 
		image.image = [UIImage imageNamed:@"pressed.png"];
	[UIView beginAnimations:@"animatecomeout" context:NULL];
	[UIView setAnimationDuration:.25f];
	if(!flag[section])
		image.transform=CGAffineTransformMakeRotation(-1.58);
	else
		image.transform=CGAffineTransformMakeRotation(1.58);
	[UIView commitAnimations];
	[button addSubview:image];
	[image release];
	
	CGFloat size = 16;
	CGFloat width = [[self.titles objectAtIndex:section] sizeWithFont:[UIFont boldSystemFontOfSize:16]].width;
	while(width>300){
		size -= 1.0;
		width = [[self.titles objectAtIndex:section] sizeWithFont:[UIFont boldSystemFontOfSize:--size]].width;
	}
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, width+200, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont boldSystemFontOfSize:size];
	label.text = [NSString stringWithFormat:@"%@ (2/%i)",[self.titles objectAtIndex:section],[array count]];
	[button addSubview:label];
	[label release];
	
	return button;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	;	
}
////////////////////////////////////

-(void)headerClicked:(id)sender
{
	int sectionIndex = ((UIButton*)sender).tag;
	flag[sectionIndex] = !flag[sectionIndex];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationTop];
	
}


- (int)numberOfRowsInSection:(NSInteger)section
{
	
	if (flag[section]) {
		return 6;
	}
	else {
		return 0;
	}
}

- (void)dealloc {
	[titles release];
	[detailView release];
	[dic release]; 
	free(flag);
    [super dealloc];
}


@end

