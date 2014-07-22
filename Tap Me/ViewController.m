//
//  ViewController.m
//  Tap Me
//
//  Created by Rakshak Kalwani on 15/07/14.
//  Copyright (c) 2014 studypad. All rights reserved.
//

#import "ViewController.h"
#import <Vessel/Vessel.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)setupGame {
  seconds = 30;
  count = 0;
  
  timerLabel.text = [NSString stringWithFormat:@"Time: %i", seconds];
  scoreLabel.text = [NSString stringWithFormat:@"Score: %i", count];
  
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                           target:self
                                         selector:@selector(subtractTime)
                                         userInfo:nil
                                          repeats:YES];
  [backgroundMusic setVolume:0.1f];
  [backgroundMusic play];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  [self setupGame];
}

- (void)subtractTime {
  seconds--;
  timerLabel.text = [NSString stringWithFormat:@"Time: %i",seconds];
  
  [secondBeep play];
  
  if(seconds == 0) {
    [timer invalidate];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                          message:[NSString stringWithFormat:@"You scored %i points", count]
                                          delegate:self
                                          cancelButtonTitle:@"Play Again"
                                          otherButtonTitles: nil];
    [alert show];
  }
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
  NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
  NSURL *url = [NSURL fileURLWithPath:path];
  
  NSError *error;
  
  AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
  
  if(!audioPlayer) {
    NSLog(@"%@", [error description]);
  }
  
  return audioPlayer;
}

- (IBAction)buttonPressed {
  count++;
  
  scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", count];
  [buttonBeep play];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  [VesselAB activateTest:@"background_image"];
  
  [VesselAB fromTest:@"background_image" getImageFor:@"bg_image" success:^(UIImage *variationImage) {
    if(variationImage) {
      self.view.backgroundColor = [UIColor colorWithPatternImage:variationImage];
    }
    else {
      self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    }
      
  } failureBlock:^{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
  }];
  
  
  
  scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
  timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
  
  buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
  secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
  backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
  
  [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
