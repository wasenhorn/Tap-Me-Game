//
//  ViewController.h
//  Tap Me
//
//  Created by Rakshak Kalwani on 15/07/14.
//  Copyright (c) 2014 studypad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIAlertViewDelegate> {
  IBOutlet UILabel *scoreLabel;
  IBOutlet UILabel *timerLabel;
  
  NSInteger count;
  NSInteger seconds;
  NSTimer *timer;
  
  AVAudioPlayer *buttonBeep;
  AVAudioPlayer *secondBeep;
  AVAudioPlayer *backgroundMusic;
}

- (IBAction)buttonPressed;
@end
