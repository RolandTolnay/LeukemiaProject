//
//  RTFirstViewController.m
//  Leukemia App
//
//  Created by dmu-23 on 15/08/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "RTPainDrawViewController.h"

@interface RTPainDrawViewController ()

@property UIPopoverController *popover;

@end

@implementation RTPainDrawViewController

- (void)viewDidLoad
{
    self.red = 255.0/255.0;
    self.green = 0.0/255.0;
    self.blue = 0.0/255.0;
    self.brush = 15.0;
    self.opacity = 0.0;
    
    [self.greenBtn setImage:[UIImage imageNamed:@"btngreen.png"] forState:UIControlStateNormal];
    [self.greenBtn setImage:[UIImage imageNamed:@"btnGreenHighligted.png"] forState:UIControlStateSelected];
    [self.greenBtn setImage:[UIImage imageNamed:@"btnGreenHighligted.png"] forState:UIControlStateHighlighted];
    
    [self.yelBtn setImage:[UIImage imageNamed:@"btnyellow.png"] forState:UIControlStateNormal];
    [self.yelBtn setImage:[UIImage imageNamed:@"btnYellowHighlighted.png"] forState:UIControlStateSelected];
    [self.yelBtn setImage:[UIImage imageNamed:@"btnYellowHighlighted.png"] forState:UIControlStateHighlighted];
    
    [self.redBtn setImage:[UIImage imageNamed:@"redbtn.png"] forState:UIControlStateNormal];
    [self.redBtn setImage:[UIImage imageNamed:@"btnRedHighlighted.png"] forState:UIControlStateSelected];
    [self.redBtn setImage:[UIImage imageNamed:@"btnRedHighlighted.png"] forState:UIControlStateHighlighted];
    
    self.redDescription = NSLocalizedString(@"Red - It hurts so much that it's unbearable", nil);
    self.yellowDescription = NSLocalizedString(@"Yellow - It hurts, but it's bearable", nil);
    self.greenDescription = NSLocalizedString(@"Green - It hurts a bit, but I hardly notice the pain", nil);
    
    [super viewDidLoad];
}

//---
//
// Code regarding orientation layout
//
//---
//
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [self layoutForOrientation:toInterfaceOrientation];
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self layoutForOrientation:self.interfaceOrientation];
//}
//
//-(void) layoutForOrientation:(UIInterfaceOrientation) orientation
//{
//    if (UIInterfaceOrientationIsLandscape(orientation))
//    {
//        self.lblBodyParts.hidden = YES;
//        self.lblInstructions.hidden = YES;
//        self.painDescriptionTxtField.hidden = YES;
//        self.btnPreview.hidden = YES;
//    } else {
//        self.lblBodyParts.hidden = NO;
//        self.lblInstructions.hidden = NO;
//        self.painDescriptionTxtField.hidden = NO;
//        self.btnPreview.hidden = NO;
//    }
//    
//}



#pragma mark - Drawing controls

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.mouseWiped = NO;
    UITouch *touch = [touches anyObject];
    if([[touch view]isEqual:self.drawingView]){
        self.lastPoint = [touch locationInView:self.drawingView];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.mouseWiped = YES;
    UITouch *touch = [touches anyObject];
    if([[touch view]isEqual:self.drawingView]){
        CGPoint currentPoint = [touch locationInView:self.drawingView];
        UIGraphicsBeginImageContext(self.drawingView.bounds.size);
        [self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawingView.bounds.size.width, self.drawingView.bounds.size.height)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.drawImage setAlpha:self.opacity];
        UIGraphicsEndImageContext();
        self.lastPoint = currentPoint;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.mouseWiped){
        UIGraphicsBeginImageContext(self.drawingView.frame.size);
        [self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawingView.bounds.size.width, self.drawingView.bounds.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.drawingView.bounds.size.width, self.drawingView.bounds.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawingView.bounds.size.width, self.drawingView.bounds.size.height) blendMode:kCGBlendModeNormal alpha:self.opacity];
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.drawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (IBAction)resetDrawing:(id)sender {
    UIImage *painBodyImage = [UIImage imageNamed:@"painDrawBody.png"];
    self.red = 255.0/255.0;
    self.green = 0.0/255.0;
    self.blue = 0.0/255.0;
    self.mainImage.image = painBodyImage;
    self.drawImage.image = painBodyImage;
    self.brush = 15.0;
    self.opacity = 0.0;
    [self.redBtn setSelected:NO];
    [self.yelBtn setSelected:NO];
    [self.greenBtn setSelected:NO];
    [self.painDescriptionTxtField setText:@""];
    [self.btnPreview setImage:[UIImage alloc]];
}

#pragma mark - Color selection method

- (IBAction)colorPressed:(id)sender {
    UIButton *pressedButton = (UIButton*)sender;
    [pressedButton setSelected:YES];
    [pressedButton setHighlighted:YES];
    if (self.opacity == 0.0)
        self.opacity = 0.7;
    switch (pressedButton.tag) {
        case 0:
            self.red = 255.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 0.0/255.0;
            [self.yelBtn setSelected:NO];
            [self.greenBtn setSelected:NO];
            [self.btnPreview setImage:[UIImage imageNamed:@"redbtn.png" ]];
            [self.painDescriptionTxtField setText:self.redDescription];
            break;
        case 1:
            self.red = 255.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            [self.redBtn setSelected:NO];
            [self.greenBtn setSelected:NO];
            [self.btnPreview setImage:[UIImage imageNamed:@"btnyellow.png" ]];
            [self.painDescriptionTxtField setText:self.yellowDescription];
            break;
        case 2:
            self.red = 102.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            [self.redBtn setSelected:NO];
            [self.yelBtn setSelected:NO];
            [self.btnPreview setImage:[UIImage imageNamed:@"btngreen.png" ]];
            [self.painDescriptionTxtField setText:self.greenDescription];
            break;
    }
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"settingsPopover"]){
        RTBrushSizeViewController *controller = [segue destinationViewController];
        controller.brushSlider.value = self.brush;
        controller.brush = [[NSNumber alloc]initWithFloat:self.brush];
        
        self.popover = [(UIStoryboardPopoverSegue*)segue popoverController];
        self.popover.delegate = self;
        return;
    }
    
    if (sender!=self.btnSaveImage)
        self.mainImage.image = nil;
}

-(IBAction)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    UIViewController *sourceViewController = popoverController.contentViewController;
    if([sourceViewController isKindOfClass:[RTBrushSizeViewController class]]){
        RTBrushSizeViewController *controller = (RTBrushSizeViewController*)sourceViewController;
        self.brush = controller.brushSlider.value;
    }
}



@end
