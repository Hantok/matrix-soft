//
//  SettingsTableViewController.h
//  Restaurant
//
//  Created by Bogdan Geleta on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingsTableViewController : UITableViewController <MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
@property (strong, nonatomic) IBOutlet UITableViewCell *styleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *currencyCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *resetCell;


@end
