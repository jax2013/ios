//
//  RootViewController.h
//  China36Plans
//
//  Created by apple on 10-10-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UITableViewController {
	
	NSArray      *titles;
	UITableView  *detailView;
	NSDictionary *dic;
	BOOL *flag;
	BOOL doFresh;
	
}

@property(nonatomic, retain) NSArray *titles;
@property(nonatomic, retain) UITableView  *detailView;
@property(nonatomic, retain) NSDictionary *dic;


- (int)numberOfRowsInSection:(NSInteger)section;

@end
