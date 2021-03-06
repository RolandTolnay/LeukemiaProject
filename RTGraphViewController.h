//
//  RTGraphViewController.h
//  Leukemia App
//
//  Created by dmu-23 on 25/08/14.
//  Copyright (c) 2014 dmu-23. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RTDataManagement.h"
#import "RTGraphCalendarViewController.h"
#import "RTGraphWeekPickerViewController.h"
#import "NSDate+convenience.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"

@interface RTGraphViewController : UIViewController <UIPopoverControllerDelegate,RTCalendarPickerDelegate,RTWeekPickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblError;

@property (weak, nonatomic) IBOutlet UIButton *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *graphType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *painType;
@property (weak, nonatomic) IBOutlet UILabel *lblPainType;

@property (strong,nonatomic) NSDate* currentDate;

-(IBAction)graphTypeChanged:(id)sender;
-(IBAction)painTypeChanged:(id)sender;
-(IBAction)pickDate:(id)sender;

@end
