//
//  ViewController.h
//  st
//
//  Created by Dhanthuluri, Mahidhar Varma (UMKC-Student) on 9/8/15.
//  Copyright (c) 2015 Dhanthuluri, Mahidhar Varma (UMKC-Student). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <SpeechKit/SpeechKit.h>

@interface ViewController : UIViewController < UITextFieldDelegate, SpeechKitDelegate, SKRecognizerDelegate >

@property (strong, nonatomic) SKRecognizer* voiceSearch;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)recordButtonTapped:(id)sender;


@end

