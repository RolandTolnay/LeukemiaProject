//
//  RTGraphViewController.h
//  Leukemia App
//
//  Created by dmu-23 on 25/08/14.
//  Copyright (c) 2014 dmu-23. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RTDataManagement.h"
#import "GraphKit.h"
#import "RTGraphCalendarViewController.h"

@interface RTGraphViewController : UIViewController <GKLineGraphDataSource,RTCalendarPickerDelegate,UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet GKLineGraph *graph;
- (IBAction)refresh:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UILabel *lblError;


- (IBAction)refreshGraph:(id)sender;


@end
