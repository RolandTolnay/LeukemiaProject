//
//  RTPainInfoViewController.m
//  Leukemia App
//
//  Created by DMU-24 on 22/10/14.
//  Copyright (c) 2014 DMU-24. All rights reserved.
//

#import "RTPainInfoViewController.h"

@interface RTPainInfoViewController ()

@end

@implementation RTPainInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataMangement = [RTDataManagement singleton];

    if (self.dataMangement.painScaleBieri) {
        self.painInformation.image = nil;
        self.noInfoLabel.text = NSLocalizedString(@"No info on this pain scale", nil);
    }
    else if (self.dataMangement.painScaleWongBaker){
        self.painInformation.image = [UIImage imageNamed:@"WongBaker_info"];
        self.noInfoLabel.text = @"";
    }
    else if (self.dataMangement.flaccScale){
        self.painInformation.image = [UIImage imageNamed:@"FLACC_info"];
        self.noInfoLabel.text = @"";
    }
}

@end
