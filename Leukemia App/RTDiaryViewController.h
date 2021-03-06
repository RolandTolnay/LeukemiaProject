//
//  RTDiaryViewController.h
//  Leukemia App
//
//  Created by dmu-23 on 15/08/14.
//  Copyright (c) 2014 dmu-23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
#import "NSDate+convenience.h"
#import "RTDataManagement.h"
#import "RTDiaryDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "RTService.h"


@interface RTDiaryViewController : UIViewController <VRGCalendarViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWeight;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProtocol;
@property (weak, nonatomic) IBOutlet UITextView *textViewNotes;
@property (weak, nonatomic) IBOutlet UILabel *labelNotesPlaceholder;

@property (strong, nonatomic) RTDataManagement *dataManagement;
@property (strong,nonatomic) NSDateFormatter *dateFormat;
@property (strong, nonatomic) NSMutableArray *painRegistrations;
@property (strong, nonatomic) NSDate *currentSelectedDate;
@property (weak, nonatomic) IBOutlet UIButton *popoverAnchorButton;
- (IBAction)exportData:(id)sender;

@end
