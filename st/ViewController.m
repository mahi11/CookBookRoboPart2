//
//  ViewController.m
//  st
//
//  Created by Dhanthuluri, Mahidhar Varma (UMKC-Student) on 9/8/15.
//  Copyright (c) 2015 Dhanthuluri, Mahidhar Varma (UMKC-Student). All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

const unsigned char SpeechKitApplicationKey[] = {0x07, 0x91, 0x98, 0x86, 0xab, 0x57, 0xbf, 0x28, 0x71, 0x48, 0xb5, 0x73, 0xab, 0xed, 0x94, 0x48, 0x39, 0xcb, 0xe2, 0x76, 0xdf, 0xce, 0xeb, 0x58, 0x3c, 0x48, 0xca, 0xde, 0x2b, 0x95, 0x28, 0x32, 0x26, 0xc0, 0xb8, 0xd1, 0x18, 0x77, 0xfa, 0x89, 0xbf, 0xaf, 0xfc, 0x6b, 0x9c, 0x91, 0xb3, 0xd5, 0x5c, 0x95, 0x4c, 0x3b, 0x63, 0x37, 0x93, 0x9f, 0x7f, 0x5d, 0x7d, 0xaa, 0xf2, 0xa5, 0xdc, 0x18};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [SpeechKit setupWithID:@"NMDPTRIAL_mahidharvarma_gmail_com20150908153035"
                      host:@"sslsandbox.nmdp.nuancemobility.net"
                      port:	443
                    useSSL:YES
                  delegate:nil];
    
    // Set earcons to play
    SKEarcon* earconStart	= [SKEarcon earconWithName:@"earcon_listening.wav"];
    SKEarcon* earconStop	= [SKEarcon earconWithName:@"earcon_done_listening.wav"];
    SKEarcon* earconCancel	= [SKEarcon earconWithName:@"earcon_cancel.wav"];
    
    [SpeechKit setEarcon:earconStart forType:SKStartRecordingEarconType];
    [SpeechKit setEarcon:earconStop forType:SKStopRecordingEarconType];
    [SpeechKit setEarcon:earconCancel forType:SKCancelRecordingEarconType];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.messageLabel.text = @"Tap on the mic";
    self.activityIndicator.hidden = YES;

    
    self.searchTextField.returnKeyType = UIReturnKeySearch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
}

# pragma mark - when record button is tapped


- (IBAction)recordButtonTapped:(id)sender {
    
    self.recordButton.selected = !self.recordButton.isSelected;
    
    // This will initialize a new speech recognizer instance
    if (self.recordButton.isSelected) {
        self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                    detection:SKShortEndOfSpeechDetection
                                                     language:@"en_US"
                                                     delegate:self];
    }
    
    // This will stop existing speech recognizer processes
    else {
        if (self.voiceSearch) {
            [self.voiceSearch stopRecording];
            [self.voiceSearch cancel];
        }
    }
}



# pragma mark - SKRecognizer Delegate Methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Listening..";
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Done Listening..";
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results {
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
        self.searchTextField.text = [results firstResult];
    }
    
    self.recordButton.selected = !self.recordButton.isSelected;
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }

}
- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion {
    self.recordButton.selected = NO;
    self.messageLabel.text = @"Connection error";
    self.activityIndicator.hidden = YES;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
    @end
