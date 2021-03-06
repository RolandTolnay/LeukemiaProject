//
//  RTAddBloodSampleViewController.m
//  Leukemia App
//
//  Created by dmu-23 on 14/10/14.
//  Copyright (c) 2014 dmu-23. All rights reserved.
//

#import "RTAddBloodSampleViewController.h"

@interface RTAddBloodSampleViewController ()

@property RTDataManagement *dataManagement;

@property UIPopoverController* popover;

@end

@implementation RTAddBloodSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManagement = [RTDataManagement singleton];
    
    if (self.selectedBloodSample != nil) //Editing blood sample
    {
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Edit blood sample"];
        [self.btnAddSample setAttributedTitle:title forState:UIControlStateNormal];
        
        self.selectedDate = [self.selectedBloodSample objectForKey:@"date"];
        NSDateFormatter *dayShortFormatter = [[NSDateFormatter alloc] init];
        [dayShortFormatter setDateFormat:@"dd/MM"];
        [self.btnDateSelector setTitle:[dayShortFormatter stringFromDate:self.selectedDate] forState:UIControlStateNormal];
        [self.btnDateSelector setEnabled:NO];
        
        [self prepareForUpdate];
        
    } else                              //Adding blood sample
    {
        self.selectedDate = [NSDate date];
        NSDateFormatter *dayShortFormatter = [[NSDateFormatter alloc] init];
        [dayShortFormatter setDateFormat:@"dd/MM"];
        [self.btnDateSelector setTitle:[dayShortFormatter stringFromDate:self.selectedDate] forState:UIControlStateNormal];
        
        [self resetView];
    }
}


-(void)resetView {
    for (UITextField *txf in self.txfBloodSamples)
    {
        [txf setText:(@"")];
        txf.delegate = self;
        [txf resignFirstResponder];
    }
}

-(void)prepareForUpdate
{
    for (UITextField *txf in self.txfBloodSamples)
    {
        NSString *bloodSampleValue;
        switch (txf.tag) {
            case 0:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"hemoglobin"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            case 1:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"thrombocytes"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            case 2:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"leukocytes"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            case 3:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"neutrofile"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            case 4:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"crp"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            case 5:
                bloodSampleValue = [[self.selectedBloodSample objectForKey:@"alat"] stringValue];
                [txf setText:[NSString stringWithFormat:@"%@",bloodSampleValue]];
                break;
            default:
                break;
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    for (UITextField *txf in self.txfBloodSamples)
    {
        if (textField.tag < 5)
            if (txf.tag == textField.tag + 1)
                [txf becomeFirstResponder];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    for (UITextField *txf in self.txfBloodSamples)
        if ([txf isFirstResponder] && [touch view] != txf)
            [txf resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Sample CRUD

- (IBAction)addSample:(id)sender {
    
    NSMutableDictionary *sampleData = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dataToBeSaved = [self.dataManagement medicineDataAtDate:self.selectedDate];
    BOOL success = YES;
    
    if(dataToBeSaved == nil && self.selectedBloodSample == nil){
        dataToBeSaved = [self.dataManagement newMedicineData:self.selectedDate];
    }
    
    for (UITextField *txf in self.txfBloodSamples)
    {
        NSString *trimmedValue = [txf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([self isProperValue:trimmedValue forInput:(int)txf.tag])
        {
            NSNumber *bloodSampleValue;
            switch (txf.tag) {
                case 0:
                    bloodSampleValue = [NSNumber numberWithFloat:[trimmedValue floatValue]];
                    [sampleData setObject:bloodSampleValue forKey:@"hemoglobin"];
                    break;
                case 1:
                    if ([trimmedValue isEqualToString:@""])
                        [sampleData setObject:@"" forKey:@"thrombocytes"];
                    else {
                        bloodSampleValue = [NSNumber numberWithInteger:[trimmedValue integerValue]];
                        [sampleData setObject:bloodSampleValue forKey:@"thrombocytes"];
                    }
                    break;
                case 2:
                    if ([trimmedValue isEqualToString:@""])
                        [sampleData setObject:@"" forKey:@"leukocytes"];
                    else {
                        bloodSampleValue = [NSNumber numberWithFloat:[trimmedValue floatValue]];
                        [sampleData setObject:bloodSampleValue forKey:@"leukocytes"];
                    }
                    break;
                case 3:
                    if ([trimmedValue isEqualToString:@""])
                        [sampleData setObject:@"" forKey:@"neutrofile"];
                    else {
                        bloodSampleValue = [NSNumber numberWithFloat:[trimmedValue floatValue]];
                        [sampleData setObject:bloodSampleValue forKey:@"neutrofile"];
                    }
                    break;
                case 4:
                    bloodSampleValue = [NSNumber numberWithInteger:[trimmedValue integerValue]];
                    [sampleData setObject:bloodSampleValue forKey:@"crp"];
                    break;
                case 5:
                    bloodSampleValue = [NSNumber numberWithInteger:[trimmedValue integerValue]];
                    [sampleData setObject:bloodSampleValue forKey:@"alat"];
                    break;
                default:
                    break;
            }
        }
        else
        {
            success = NO;
            
            NSString *message = [NSString stringWithFormat: NSLocalizedString(@"Unexpected input at textfield %d", @"Message on bloodsample error"),txf.tag];
            
            UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [toast show];
            break;
        }
    }
    
    if (success)
    {
        [dataToBeSaved setObject:sampleData forKey:@"bloodSample"];
        [self.dataManagement writeToPList];
    }
    [self resetView];
}


-(BOOL) isProperValue:(NSString*) value forInput:(int) tag
{
    switch (tag) {
        case 0:
            if ([value floatValue] >= 2.0 && [value floatValue]<=10.0) return YES;
        case 1:
            if ([value isEqualToString:@""]) return YES;
            if ([value integerValue] >= 0 && [value integerValue] <= 999) return YES;
        case 2:
            if ([value isEqualToString:@""]) return YES;
            if ([value floatValue] >= 0.0 && [value floatValue]<=100.0) return YES;
        case 3:
            if ([value isEqualToString:@""]) return YES;
            if ([value floatValue] >= 0.0 && [value floatValue]<=20.0) return YES;
        case 4:
            if ([value integerValue] >= 1 && [value integerValue] <= 999) return YES;
        case 5:
            if ([value integerValue] >= 99 && [value integerValue] <= 9999) return YES;
        default:
            return NO;
    }
    return NO;
}

-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"bloodSampleDatePicker"]){
        RTGraphCalendarViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        controller.pickedDate = self.selectedDate;
        controller.markedDates = [self.dataManagement datesWithBloodSamplesFromDate:self.selectedDate];
        
        self.popover = [(UIStoryboardPopoverSegue*)segue popoverController];
        self.popover.delegate = self;
    }
}

#pragma mark - Calendar Picker Delegate

-(void)dateSelected:(NSDate *)date
{
    self.selectedDate = date;
    NSDateFormatter *dayShortFormatter = [[NSDateFormatter alloc] init];
    [dayShortFormatter setDateFormat:@"dd/MM"];
    [self.btnDateSelector setTitle:[dayShortFormatter stringFromDate:self.selectedDate] forState:UIControlStateNormal];
    
    if ([[RTService singleton] isDate:date earlierThanDate:[NSDate date]])
        self.btnAddSample.hidden = NO;
    else self.btnAddSample.hidden = YES;
    
    [self.popover dismissPopoverAnimated:YES];
}

-(NSArray *)monthChanged:(NSInteger)month
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *monthString = [@(month) stringValue];
    NSDate *newDate = [dateFormatter dateFromString:monthString];
    return [self.dataManagement datesWithBloodSamplesFromDate:newDate];
}

@end
