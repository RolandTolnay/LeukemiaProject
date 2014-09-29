//
//  RTDataManagement.h
//  Leukemia App
//
//  Created by DMU-24 on 22/08/14.
//  Copyright (c) 2014 DMU-24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTConstants.h"
#include <stdlib.h>
#import "NSDate+convenience.h"

@interface RTDataManagement : NSObject

//pList properties
@property (strong,nonatomic) NSMutableArray *painData;
@property (strong,nonatomic) NSMutableArray *diaryData;
@property (strong, nonatomic) NSMutableDictionary *bloodSampleData;
@property (strong, nonatomic) NSString *path;

@property (nonatomic) NSUserDefaults *prefs;
//NSUserDefault - painScaleSettings
@property NSInteger selectedRowPainScale;
@property BOOL painScaleBieri;
//NSUserDefault - notificationsettings
@property NSInteger selectedRowNotification;
@property BOOL notificationsOn;

+(RTDataManagement *)singleton;
-(void)saveUserPrefrences;
//-(id)initWithPlistAndUserPreferences;
-(void)writeToPList;
-(void)reloadPlist;

//service methods for graph data-management
-(NSArray*) painLevelsAtDay:(NSString*) day forPainType:(NSString *) painType;
-(NSArray*) timeStampsAtDay:(NSString*) day;
-(BOOL) isEnoughDataAtDay:(NSString *) day;
-(NSArray*) datesWithGraphFromDate: (NSDate*) currentDate;
-(NSMutableDictionary*) diaryDataAtDate:(NSDate*) date;
-(NSArray*)allDatesInWeek:(long)weekNumber forYear:(int)year;

//image reading and writing
-(void) UIImageWriteToFile:(UIImage *)image :(NSString *)fileName;
-(void) UIImageReadFromFile:(UIImage **)image :(NSString *)fileName;

//testing
-(void) initTestData;

@end
